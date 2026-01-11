# -*- coding: utf-8 -*-
"""
API de recommandations de films - Mini Netflix BigData
Endpoints:
  - GET /health              → Vérification santé de l'API
  - GET /reco/{user_id}?n=10 → Recommandations pour un user
  - GET /reco/random?n=10    → Recommandations pour un user aléatoire
  - GET /docs                → Documentation Swagger automatique
"""

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import psycopg2
from psycopg2.extras import RealDictCursor
import os
from typing import List, Dict, Any
import random

# ========== CONFIGURATION ==========
app = FastAPI(
    title="Mini Netflix - API Recommandations",
    description="API pour récupérer les recommandations de films générées par ALS (Spark)",
    version="1.0.0"
)

# ✅ CORS : Autoriser les appels depuis le front (localhost:5173, localhost:3000, etc.)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # En prod, mettre uniquement les URLs autorisées
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ✅ Configuration PostgreSQL
# On utilise 127.0.0.1 et le port 5433 pour éviter les conflits avec Postgres local
PG_HOST = os.getenv("PG_HOST", "127.0.0.1")
PG_PORT = int(os.getenv("PG_PORT", "5433"))
PG_DB = os.getenv("POSTGRES_DB", "postgres")
PG_USER = os.getenv("POSTGRES_USER", "postgres")
PG_PASS = os.getenv("POSTGRES_PASSWORD", "postgres")


# ========== CONNEXION DATABASE ==========
def get_conn():
    """Crée une connexion PostgreSQL avec encodage UTF-8"""
    try:
        conn = psycopg2.connect(
            host=PG_HOST,
            port=PG_PORT,
            dbname=PG_DB,
            user=PG_USER,
            password=PG_PASS,
            connect_timeout=5
        )
        conn.set_client_encoding("UTF8")
        return conn
    except Exception as e:
        print(f"❌ Erreur de connexion DB: {e}")
        raise HTTPException(
            status_code=503,
            detail=f"Impossible de se connecter à la base de données: {str(e)}"
        )


# ========== ENDPOINTS ==========

@app.get("/", tags=["Root"])
def root():
    """Page d'accueil de l'API"""
    return {
        "message": "🎬 Bienvenue sur l'API Mini Netflix BigData",
        "endpoints": {
            "/health": "Vérifier l'état de l'API",
            "/reco/{user_id}?n=10": "Obtenir des recommandations pour un utilisateur",
            "/reco/random?n=10": "Obtenir des recommandations pour un utilisateur aléatoire",
            "/docs": "Documentation Swagger interactive"
        }
    }


@app.get("/health", tags=["Health"])
def health():
    """Vérifie que l'API et la base de données sont opérationnelles"""
    try:
        conn = get_conn()
        cur = conn.cursor()
        cur.execute("SELECT 1")
        cur.close()
        conn.close()
        return {
            "status": "ok",
            "database": "connected"
        }
    except Exception as e:
        raise HTTPException(
            status_code=503,
            detail=f"Database connection failed: {str(e)}"
        )


@app.get("/reco/{user_id}", tags=["Recommendations"])
def get_recommendations(user_id: int, n: int = 10):
    """
    Récupère les N meilleures recommandations pour un utilisateur donné
    """
    if n <= 0:
        raise HTTPException(status_code=400, detail="Le paramètre 'n' doit être supérieur à 0")
    
    try:
        conn = get_conn()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        
        cur.execute("""
            SELECT user_id, movie_id, title, score
            FROM public.als_recos
            WHERE user_id = %s
            ORDER BY score DESC
            LIMIT %s
        """, (user_id, n))
        
        rows = cur.fetchall()
        cur.close()
        conn.close()
        
        if len(rows) == 0:
            raise HTTPException(status_code=404, detail=f"Aucune recommandation trouvée pour l'utilisateur {user_id}")
        
        return {
            "user_id": user_id,
            "n": len(rows),
            "results": rows
        }
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur serveur: {str(e)}")


@app.get("/reco/random", tags=["Recommendations"])
def get_random_recommendations(n: int = 10):
    """
    Récupère les N meilleures recommandations pour un utilisateur aléatoire
    """
    try:
        conn = get_conn()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        
        cur.execute("SELECT DISTINCT user_id FROM public.als_recos ORDER BY RANDOM() LIMIT 1")
        result = cur.fetchone()
        
        if not result:
            raise HTTPException(status_code=404, detail="Aucune donnée disponible")
        
        random_user_id = result['user_id']
        
        cur.execute("""
            SELECT user_id, movie_id, title, score
            FROM public.als_recos
            WHERE user_id = %s
            ORDER BY score DESC
            LIMIT %s
        """, (random_user_id, n))
        
        rows = cur.fetchall()
        cur.close()
        conn.close()
        
        return {
            "user_id": random_user_id,
            "n": len(rows),
            "results": rows,
            "is_random": True
        }
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur serveur: {str(e)}")
