# 📊 ARCHITECTURE DU PROJET - Mini Netflix BigData

## 🎯 Vue d'Ensemble

Ce projet est un **système de recommandations de films** utilisant :
- **Machine Learning** : ALS (Alternating Least Squares) avec Apache Spark
- **Backend** : API REST avec FastAPI (Python)
- **Base de données** : PostgreSQL
- **Frontend** : 2 versions (HTML pur et React)

---

## 📁 Structure Complète du Projet

```
mini-netflix-bigdata/
│
├── 📂 api/                           # Backend API
│   ├── 07_api_recos.py              # API FastAPI principale
│   └── requirements.txt              # Dépendances Python
│
├── 📂 frontend/                      # Interfaces utilisateur
│   ├── 📂 html-pure/                # Version HTML/CSS/JS
│   │   └── index.html               # Page unique (tout-en-un)
│   └── 📂 react-vite/               # Version React moderne
│       ├── 📂 src/
│       │   ├── App.jsx              # Composant principal
│       │   ├── App.css              # Styles
│       │   └── main.jsx             # Point d'entrée
│       ├── index.html               # HTML de base
│       ├── package.json             # Config Node.js
│       └── vite.config.js           # Config Vite
│
├── 📂 spark/                         # Scripts BigData
│   ├── 01_ingest_hdfs.py            # Import données HDFS
│   ├── 02_clean_sql_stats.py        # Nettoyage données
│   ├── 03_train_als.py              # Entraînement modèle ALS
│   ├── 04_generate_recos.py         # Génération recommandations
│   ├── 06_export_recos_postgres.py  # Export vers PostgreSQL
│   └── ...                          # Autres scripts
│
├── 📂 data/                          # Données brutes
├── 📂 db/                            # Config base de données
├── 📂 grafana/                       # Monitoring (optionnel)
│
├── .env                             # Variables d'environnement
├── .gitignore                       # Fichiers à ignorer (Git)
├── docker-compose.yml               # Orchestration Docker
├── README.md                        # Documentation complète
├── QUICKSTART.md                    # Démarrage rapide
├── ARCHITECTURE.md                  # Ce fichier
└── start.ps1                        # Script de lancement auto
```

---

## 🔄 Flux de Données (Data Pipeline)

```
┌─────────────┐
│  Données    │  MovieLens / Netflix
│   Brutes    │  (ratings.csv, movies.csv)
└──────┬──────┘
       │
       ▼
┌─────────────────────────────────┐
│  1. INGESTION (Spark)           │
│  01_ingest_hdfs.py              │  ← Import dans HDFS
└──────────┬──────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│  2. NETTOYAGE (Spark SQL)       │
│  02_clean_sql_stats.py          │  ← Suppression doublons, nulls
└──────────┬──────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│  3. ENTRAÎNEMENT ML (Spark MLlib)│
│  03_train_als.py                │  ← Modèle ALS
│  • rank = 10                    │
│  • maxIter = 10                 │
│  • regParam = 0.01              │
└──────────┬──────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│  4. GÉNÉRATION RECOS            │
│  04_generate_recos.py           │  ← Top 10 par user
└──────────┬──────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│  5. EXPORT POSTGRES             │
│  06_export_recos_postgres.py    │  ← Table als_recos
└──────────┬──────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│  📊 PostgreSQL                  │
│  Table: public.als_recos        │
│  (user_id, movie_id, title, score)
└──────────┬──────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│  6. API REST (FastAPI)          │
│  07_api_recos.py                │  ← Endpoints HTTP
│  • GET /reco/{user_id}          │
│  • GET /reco/random              │
└──────────┬──────────────────────┘
           │
           ▼
┌─────────────────────────────────┐
│  7. FRONTEND                    │
│  HTML ou React                  │  ← Interface utilisateur
│  • Formulaire                   │
│  • Affichage tableau            │
└─────────────────────────────────┘
```

---

## 🏗️ Architecture Technique

### Backend (API)

```python
FastAPI
├── CORS Middleware        # Autorise appels depuis frontend
├── Endpoints:
│   ├── GET /              # Page d'accueil
│   ├── GET /health        # Health check + test DB
│   ├── GET /reco/{user_id}?n=10  # Recommandations user
│   └── GET /reco/random?n=10     # Random user
├── PostgreSQL Connection
│   ├── psycopg2           # Driver PostgreSQL
│   └── UTF-8 encoding     # Gestion accents
└── Documentation auto
    ├── /docs (Swagger)
    └── /redoc
```

### Base de Données (PostgreSQL)

```sql
Table: public.als_recos

Schéma:
┌──────────┬──────────┬─────────┬──────────┐
│ user_id  │ movie_id │  title  │  score   │
│   INT    │   INT    │  TEXT   │  FLOAT   │
├──────────┼──────────┼─────────┼──────────┤
│    1     │   123    │ Titanic │  0.9845  │
│    1     │   456    │ Avatar  │  0.9721  │
│   ...    │   ...    │  ...    │   ...    │
└──────────┴──────────┴─────────┴──────────┘

Index recommandé:
- CREATE INDEX idx_user ON als_recos(user_id);
```

### Frontend HTML Pur

```
index.html (tout-en-un)
├── HTML
│   ├── Formulaire (user_id, n)
│   └── Tableau résultats
├── CSS
│   ├── Design moderne (gradient)
│   ├── Animations (fadeIn, shake)
│   └── Responsive (mobile-friendly)
└── JavaScript
    ├── fetch API
    ├── Gestion erreurs
    └── Loading spinner
```

### Frontend React

```
react-vite/
├── src/
│   ├── main.jsx           # Point d'entrée React
│   ├── App.jsx            # Composant principal
│   │   ├── useState       # Gestion état
│   │   ├── fetch          # Appels API
│   │   └── Conditional rendering
│   └── App.css            # Styles
├── Vite                   # Build tool ultra-rapide
└── Hot Module Replacement # Rechargement auto
```

---

## 🔐 Sécurité et Bonnes Pratiques

### ✅ Implémenté

1. **CORS** : Configuré pour autoriser les appels depuis le frontend
2. **UTF-8** : Encodage forcé pour gérer les accents
3. **Gestion d'erreurs** : Messages clairs pour l'utilisateur
4. **Validation** : Paramètres `n` limité à 1-100
5. **Health checks** : Endpoint pour vérifier l'état

### 🔜 Améliorations futures (Production)

1. **Authentification** : JWT tokens pour sécuriser l'API
2. **Rate limiting** : Limiter le nombre de requêtes par IP
3. **HTTPS** : Certificat SSL pour connexions sécurisées
4. **Variables d'environnement** : Ne jamais commit `.env`
5. **Logs** : Système de logging (ELK, CloudWatch...)
6. **Cache** : Redis pour accélérer les requêtes fréquentes
7. **Containerisation** : Docker pour déploiement

---

## 📊 Technologies Utilisées

### Backend
| Technologie | Version | Rôle |
|------------|---------|------|
| **Python** | 3.8+ | Langage backend |
| **FastAPI** | 0.104+ | Framework API REST |
| **Uvicorn** | 0.24+ | Serveur ASGI |
| **psycopg2** | 2.9+ | Driver PostgreSQL |
| **Apache Spark** | 3.x | Machine Learning (ALS) |

### Frontend
| Technologie | Version | Rôle |
|------------|---------|------|
| **HTML5** | - | Structure |
| **CSS3** | - | Design & animations |
| **JavaScript** | ES6+ | Logique client |
| **React** | 18.2 | UI library |
| **Vite** | 5.0 | Build tool |

### Infrastructure
| Technologie | Version | Rôle |
|------------|---------|------|
| **PostgreSQL** | 14+ | Base de données |
| **Docker** | 20+ | Containerisation |
| **HDFS** | - | Stockage BigData |

---

## 🧪 Endpoints API - Détails

### 1. `GET /`
**Description** : Page d'accueil avec liste des endpoints

**Réponse** :
```json
{
  "message": "🎬 Bienvenue sur l'API Mini Netflix BigData",
  "endpoints": {
    "/health": "...",
    "/reco/{user_id}": "...",
    ...
  }
}
```

---

### 2. `GET /health`
**Description** : Vérifie l'état de l'API et la connexion DB

**Réponse succès** :
```json
{
  "status": "ok",
  "database": "connected"
}
```

**Réponse erreur** :
```json
{
  "detail": "Database connection failed: ..."
}
```

---

### 3. `GET /reco/{user_id}?n=10`
**Description** : Recommandations pour un utilisateur

**Paramètres** :
- `user_id` (path) : ID de l'utilisateur (int)
- `n` (query, optionnel) : Nombre de recommandations (défaut: 10, max: 100)

**Réponse succès** :
```json
{
  "user_id": 123,
  "n": 10,
  "results": [
    {
      "user_id": 123,
      "movie_id": 456,
      "title": "Titanic",
      "score": 0.9845
    },
    ...
  ]
}
```

**Codes d'erreur** :
- `400` : Paramètre `n` invalide
- `404` : Aucune recommandation pour cet user_id
- `500` : Erreur serveur
- `503` : Base de données inaccessible

---

### 4. `GET /reco/random?n=10`
**Description** : Recommandations pour un user aléatoire  
**Bonus** : Utile pour tester sans connaître les user_id

**Paramètres** :
- `n` (query, optionnel) : Nombre de recommandations (défaut: 10)

**Réponse succès** :
```json
{
  "user_id": 789,
  "n": 5,
  "results": [...],
  "is_random": true
}
```

---

## 🎨 Design Pattern & Choix Techniques

### API : **Architecture REST**
- **Stateless** : Chaque requête est indépendante
- **JSON** : Format d'échange standard
- **HTTP verbs** : GET pour lecture (idempotent)

### Frontend : **Component-based** (React)
- **Composants réutilisables** : Modularité
- **State management** : `useState` pour simplicité
- **Unidirectional data flow** : Facile à déboguer

### Base de données : **Modèle relationnel**
- **Table dénormalisée** : Performance (pas de JOIN)
- **Index sur user_id** : Accélère les requêtes

---

## 📏 Contraintes et Limites

### Limites actuelles
1. **Pas d'authentification** : API ouverte (OK pour dev)
2. **Pas de cache** : Chaque requête interroge la DB
3. **Pas de pagination** : Max 100 résultats
4. **Données statiques** : Modèle ALS pas re-entraîné en temps réel

### Scalabilité
Pour **millions d'utilisateurs** :
- Ajouter **Redis** pour cache
- Utiliser **load balancer** (NGINX)
- Séparer **read/write databases** (replica)
- Passer à **microservices** (API Gateway)

---

## 🚀 Déploiement

### Développement (local)
```powershell
# Méthode 1 : Script auto
.\start.ps1

# Méthode 2 : Manuel
cd api && uvicorn 07_api_recos:app --reload
cd frontend/react-vite && npm run dev
```

### Production (cloud)
1. **Backend** : Heroku, AWS Elastic Beanstalk, Google Cloud Run
2. **Frontend** : Vercel, Netlify, AWS S3 + CloudFront
3. **Base de données** : AWS RDS, Google Cloud SQL

**Exemple Docker Compose** (déjà présent) :
```yaml
services:
  postgres:
    image: postgres:14
    ...
  api:
    build: ./api
    ...
  frontend:
    build: ./frontend/react-vite
    ...
```

---

## 📚 Glossaire (pour débutants)

| Terme | Explication Simple |
|-------|-------------------|
| **API** | Interface pour que 2 programmes communiquent (ici : frontend ↔ backend) |
| **REST** | Style d'API utilisant HTTP (GET, POST, PUT, DELETE) |
| **CORS** | Permission pour appels entre domaines différents (localhost:5173 → localhost:8000) |
| **JSON** | Format de données texte `{"key": "value"}` |
| **ALS** | Algorithme de recommandation (Alternating Least Squares) |
| **UTF-8** | Encodage pour gérer tous les caractères (é, è, à, 中文, عربي...) |
| **Endpoint** | URL spécifique de l'API (`/reco/{user_id}`) |
| **Query param** | Paramètre dans l'URL (`?n=10`) |
| **Path param** | Variable dans le chemin (`/reco/{user_id}`) |

---

## 🎓 Concepts Clés

### 1. Système de Recommandations
**Principe** : Prédire ce qu'un utilisateur va aimer  
**Méthode ici** : **Collaborative filtering** (filtrage collaboratif)

```
User A aime [Film1, Film2, Film3]
User B aime [Film2, Film3, Film4]
→ L'algorithme recommande Film4 à User A
```

### 2. ALS (Alternating Least Squares)
**Objectif** : Factoriser la matrice users × films

```
         Film1  Film2  Film3
User1    4.5    ?      3.0
User2    ?      5.0    4.0

→ ALS prédit les "?"
```

### 3. API REST
**Request** :
```
GET /reco/123?n=5
Host: localhost:8000
```

**Response** :
```json
{
  "user_id": 123,
  "n": 5,
  "results": [...]
}
```

---

## 📊 Métriques de Performance

### API
- **Latence** : ~ 50-200 ms (selon taille DB)
- **Throughput** : ~ 100 req/s (sans cache)
- **Disponibilité** : Dépend de PostgreSQL

### Frontend
- **First Contentful Paint** : < 1s
- **Time to Interactive** : < 2s
- **Bundle size** (React) : ~ 150 KB

---

## 🐛 Debugging

### Problème : API ne répond pas
```powershell
# Vérifier que le serveur tourne
netstat -an | findstr "8000"

# Tester directement
Invoke-RestMethod http://localhost:8000/health
```

### Problème : CORS error
**Symptôme** : Erreur dans la console du navigateur  
**Solution** : Vérifier que l'API a bien le middleware CORS

### Problème : "Aucune recommandation"
```sql
-- Vérifier les données
SELECT DISTINCT user_id FROM public.als_recos LIMIT 10;
```

---

## 🎯 Roadmap Améliorations

### Court terme (1 semaine)
- [ ] Ajouter tests unitaires (pytest)
- [ ] Ajouter CI/CD (GitHub Actions)
- [ ] Dockeriser le projet complet

### Moyen terme (1 mois)
- [ ] Authentification JWT
- [ ] Cache Redis
- [ ] Dashboard admin (stats)
- [ ] Déploiement cloud

### Long terme (3 mois)
- [ ] Re-entraînement automatique du modèle
- [ ] A/B testing des recommandations
- [ ] Recommandations en temps réel (streaming)
- [ ] App mobile (React Native)

---

**Auteur** : Mini Netflix BigData Project  
**Date** : Janvier 2026  
**Version** : 1.0.0  
**Licence** : MIT (usage libre pour apprentissage)
