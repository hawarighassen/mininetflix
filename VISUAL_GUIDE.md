# 🎨 GUIDE VISUEL - Mini Netflix BigData

## 📸 Aperçu de l'Interface

### Frontend - Page d'accueil
```
┌─────────────────────────────────────────────────────────┐
│                    🎬 Mini Netflix                      │
│        Système de recommandations BigData              │
│              (ALS + Spark)                              │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌───────────────────────────────────────────────────┐ │
│  │  👤 User ID            🎯 Nombre de recommandations│ │
│  │  ┌──────────────┐      ┌──────────────┐           │ │
│  │  │    123       │      │      10      │           │ │
│  │  └──────────────┘      └──────────────┘           │ │
│  │                                                    │ │
│  │  ┌────────────────────┐  ┌────────────────────┐  │ │
│  │  │ 🔍 Get            │  │ 🎲 Random User    │  │ │
│  │  │   Recommendations │  │                    │  │ │
│  │  └────────────────────┘  └────────────────────┘  │ │
│  └───────────────────────────────────────────────────┘ │
│                                                         │
│  ┌───────────────────────────────────────────────────┐ │
│  │              📊 Recommandations                   │ │
│  │  User ID: 123 | 10 recommandation(s)             │ │
│  ├───────────────────────────────────────────────────┤ │
│  │  # │ 🎬 Titre du Film │ 🆔 Movie ID │ ⭐ Score    │ │
│  ├───────────────────────────────────────────────────┤ │
│  │ ① │ Titanic          │    456      │  0.9845     │ │
│  │ ② │ Avatar           │    789      │  0.9721     │ │
│  │ ③ │ Inception        │    234      │  0.9612     │ │
│  │ ④ │ The Matrix       │    567      │  0.9504     │ │
│  │ ⑤ │ Interstellar     │    890      │  0.9398     │ │
│  │ ... │                                              │ │
│  └───────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

---

## 🌐 API Swagger Documentation

### Page /docs
```
┌─────────────────────────────────────────────────────────┐
│  Mini Netflix - API Recommandations      [v1.0.0]      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  📘 Endpoints                                           │
│                                                         │
│  ▼ Root                                                 │
│     GET  /          Page d'accueil de l'API            │
│                                                         │
│  ▼ Health                                               │
│     GET  /health    Vérifier l'état de l'API           │
│                                                         │
│  ▼ Recommendations                                      │
│     GET  /reco/{user_id}   Recommandations utilisateur │
│     GET  /reco/random      User aléatoire              │
│                                                         │
│  [Try it out] bouton pour tester directement           │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Exemple de test dans Swagger** :
```
┌─────────────────────────────────────────────────────────┐
│  GET /reco/{user_id}                                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Parameters:                                            │
│    user_id*  [  123  ]  (required)                     │
│    n         [  10   ]  (optional, default: 10)        │
│                                                         │
│  [ Execute ]                                            │
│                                                         │
│  Response (200 OK):                                     │
│  {                                                      │
│    "user_id": 123,                                      │
│    "n": 10,                                             │
│    "results": [                                         │
│      {                                                  │
│        "user_id": 123,                                  │
│        "movie_id": 456,                                 │
│        "title": "Titanic",                              │
│        "score": 0.9845                                  │
│      },                                                 │
│      ...                                                │
│    ]                                                    │
│  }                                                      │
└─────────────────────────────────────────────────────────┘
```

---

## 💻 Terminal - Lancement de l'API

```
PS C:\Users\hawar\Desktop\mini-netflix-bigdata\api> uvicorn 07_api_recos:app --reload

INFO:     Will watch for changes in these directories: ['C:\\Users\\hawar\\Desktop\\mini-netflix-bigdata\\api']
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process [12345] using WatchFiles
INFO:     Started server process [67890]
INFO:     Waiting for application startup.
INFO:     Application startup complete.

✅ API prête !
📖 Documentation : http://localhost:8000/docs
```

---

## 💻 Terminal - Lancement Frontend React

```
PS C:\Users\hawar\Desktop\mini-netflix-bigdata\frontend\react-vite> npm run dev

> mini-netflix-react@1.0.0 dev
> vite

  VITE v5.0.8  ready in 324 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
  ➜  press h to show help

✅ Frontend prêt !
🌐 Ouvrir : http://localhost:5173
```

---

## 🧪 Tests PowerShell

### Test Health Check
```powershell
PS> Invoke-RestMethod http://localhost:8000/health

status   : ok
database : connected

✅ API fonctionne !
```

---

### Test Recommandations Random
```powershell
PS> Invoke-RestMethod "http://localhost:8000/reco/random?n=5"

user_id   : 123
n         : 5
is_random : True
results   : {@{user_id=123; movie_id=456; title=Titanic; score=0.9845}, ...}

✅ Recommandations reçues !
```

---

### Test avec Formatage
```powershell
PS> (Invoke-RestMethod "http://localhost:8000/reco/random?n=3").results | Format-Table

user_id movie_id title         score
------- -------- -----         -----
    123      456 Titanic       0.9845
    123      789 Avatar        0.9721
    123      234 Inception     0.9612

✅ Affichage en tableau !
```

---

## 🎬 Workflow Complet (Step-by-Step)

### Étape 1 : PostgreSQL
```
┌─────────────────────────────────────┐
│  Docker / Service PostgreSQL        │
├─────────────────────────────────────┤
│  Container: postgres                │
│  Port: 5432                         │
│  Database: postgres                 │
│  Table: public.als_recos            │
│  Status: ✅ Running                 │
└─────────────────────────────────────┘
```

**Commande** :
```powershell
docker ps
# Vérifier que "postgres" apparaît
```

---

### Étape 2 : API FastAPI
```
┌─────────────────────────────────────┐
│  API FastAPI                        │
├─────────────────────────────────────┤
│  URL: http://localhost:8000         │
│  Status: ✅ Running                 │
│  Endpoints: 5                       │
│  Database: ✅ Connected             │
└─────────────────────────────────────┘
```

**Commande** :
```powershell
cd api
uvicorn 07_api_recos:app --reload
```

**Vérification** :
```powershell
Invoke-RestMethod http://localhost:8000/health
# Doit retourner: {"status": "ok", "database": "connected"}
```

---

### Étape 3 : Frontend
```
┌─────────────────────────────────────┐
│  Frontend (React ou HTML)           │
├─────────────────────────────────────┤
│  URL: http://localhost:5173         │
│       ou http://localhost:3000      │
│  Status: ✅ Running                 │
│  API: ✅ Connected                  │
└─────────────────────────────────────┘
```

**Commande React** :
```powershell
cd frontend\react-vite
npm install
npm run dev
```

**OU Commande HTML** :
```powershell
cd frontend\html-pure
# Double-cliquer sur index.html
```

---

## 🔁 Flux de Données Complet

```
┌─────────────┐
│   USER      │  1. Clique sur "Get Recommendations"
│  (Browser)  │     avec user_id = 123, n = 10
└──────┬──────┘
       │
       │ 2. fetch("http://localhost:8000/reco/123?n=10")
       ▼
┌──────────────┐
│  Frontend    │  3. Affiche "Loading..."
│  React/HTML  │
└──────┬───────┘
       │
       │ 4. HTTP GET Request
       ▼
┌──────────────┐
│  FastAPI     │  5. Reçoit la requête
│  (Backend)   │     Valide les paramètres (user_id, n)
└──────┬───────┘
       │
       │ 6. SELECT FROM public.als_recos WHERE user_id=123 LIMIT 10
       ▼
┌──────────────┐
│  PostgreSQL  │  7. Retourne les données (films + scores)
│  (Database)  │
└──────┬───────┘
       │
       │ 8. Rows (JSON)
       ▼
┌──────────────┐
│  FastAPI     │  9. Formate en JSON :
│              │     {
│              │       "user_id": 123,
│              │       "n": 10,
│              │       "results": [...]
│              │     }
└──────┬───────┘
       │
       │ 10. HTTP Response (200 OK)
       ▼
┌──────────────┐
│  Frontend    │  11. Reçoit le JSON
│              │      Parse les données
│              │      Cache le "Loading"
└──────┬───────┘
       │
       │ 12. Affiche le tableau
       ▼
┌──────────────┐
│   USER       │  13. Voit les recommandations
│              │      Titanic, Avatar, Inception...
└──────────────┘
```

**Temps total** : 50-200 ms

---

## ❌ Gestion des Erreurs (Visuellement)

### Cas 1 : User ID vide
```
┌─────────────────────────────────────┐
│  👤 User ID: [        ]             │
│  🎯 Nombre: [ 10 ]                  │
│                                     │
│  [ Get Recommendations ]            │
└─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────┐
│  ❌ Erreur:                         │
│  Veuillez entrer un User ID         │
└─────────────────────────────────────┘
```

---

### Cas 2 : User inexistant
```
Input: user_id = 999999

                ↓

┌─────────────────────────────────────┐
│  ❌ Erreur:                         │
│  Aucune recommandation trouvée      │
│  pour l'utilisateur 999999          │
└─────────────────────────────────────┘
```

**Solution** : Utiliser "Random User"

---

### Cas 3 : API inaccessible
```
fetch("http://localhost:8000/reco/123")

                ↓

┌─────────────────────────────────────┐
│  ❌ Erreur:                         │
│  Failed to fetch                    │
│                                     │
│  Vérifier que l'API tourne sur      │
│  http://localhost:8000              │
└─────────────────────────────────────┘
```

**Solution** : Lancer l'API dans un terminal

---

## 🎯 Checklist Visuelle

### Avant de commencer
```
☐ PostgreSQL installé
☐ Python 3.8+ installé
☐ Node.js installé (si React)
☐ Git installé (optionnel)
```

---

### Lancement
```
☐ PostgreSQL lancé (docker ps)
☐ Table als_recos a des données
☐ Terminal 1 : API lancée (port 8000)
☐ Terminal 2 : Frontend lancé (port 3000 ou 5173)
```

---

### Validation
```
☐ http://localhost:8000/health → {"status": "ok"}
☐ http://localhost:8000/docs → Swagger affiché
☐ Frontend s'ouvre sans erreur
☐ Bouton "Random User" fonctionne
☐ Tableau affiche les films
☐ Accents affichés correctement (é, è, à)
```

---

## 🎨 Couleurs et Design

### Palette de Couleurs
```
Primary (Gradient):
┌────────┬────────┐
│ #667eea│ #764ba2│  Violet → Pourpre
└────────┴────────┘

Success:
┌────────┐
│ #2e7d32│  Vert foncé
└────────┘

Error:
┌────────┐
│ #c33333│  Rouge
└────────┘

Background:
┌────────┐
│ #f8f9fa│  Gris très clair
└────────┘
```

---

### Animations

**FadeIn** : Apparition en douceur
```
0%   → Opacity: 0, translateY(20px)
100% → Opacity: 1, translateY(0)
```

**Shake** : Effet de vibration (erreur)
```
0%   → translateX(0)
25%  → translateX(-10px)
75%  → translateX(10px)
100% → translateX(0)
```

**Spin** : Rotation (loading)
```
0%   → rotate(0deg)
100% → rotate(360deg)
```

---

## 📱 Responsive Design

### Desktop (> 768px)
```
┌──────────────────────────────────────┐
│  🎬 Mini Netflix                     │
│  [User ID]  [Nombre]  [Boutons]      │
│  [        Tableau complet        ]   │
└──────────────────────────────────────┘
```

---

### Mobile (< 768px)
```
┌────────────────┐
│ 🎬 Mini Netflix│
│ [User ID]      │
│ [Nombre]       │
│ [ Bouton 1 ]   │
│ [ Bouton 2 ]   │
│ [  Tableau  ]  │
│ [ (scroll →) ] │
└────────────────┘
```

---

## 🚀 Commandes Rapides (Cheat Sheet)

### API
```powershell
# Lancer
cd api
uvicorn 07_api_recos:app --reload

# Tester
Invoke-RestMethod http://localhost:8000/health
Invoke-RestMethod http://localhost:8000/reco/random?n=5
```

---

### Frontend HTML
```powershell
cd frontend\html-pure
python -m http.server 3000
# Ouvrir : http://localhost:3000
```

---

### Frontend React
```powershell
cd frontend\react-vite
npm install      # Une seule fois
npm run dev      # À chaque fois
# Ouvrir : http://localhost:5173
```

---

### PostgreSQL (Docker)
```powershell
# Lancer
docker-compose up -d postgres

# Vérifier
docker ps

# Se connecter
docker exec -it <container_id> psql -U postgres

# Dans psql:
\c postgres
SELECT COUNT(*) FROM public.als_recos;
```

---

### Tests
```powershell
# Tests automatiques
.\test_api.ps1

# Lancement complet
.\start.ps1
```

---

## 📊 Résumé Visuel de l'Architecture

```
┌───────────────────────────────────────────────────────┐
│                    ARCHITECTURE                       │
├───────────────────────────────────────────────────────┤
│                                                       │
│  ┌─────────────┐        ┌─────────────┐             │
│  │  Frontend   │  HTTP  │   Backend   │             │
│  │  React/HTML │───────▶│   FastAPI   │             │
│  │  :5173/3000 │◀───────│    :8000    │             │
│  └─────────────┘  JSON  └──────┬──────┘             │
│                                 │ SQL                │
│                          ┌──────▼──────┐             │
│                          │  PostgreSQL │             │
│                          │    :5432    │             │
│                          └─────────────┘             │
│                                                       │
│  Technologies:                                        │
│  • Frontend: React 18 / HTML5 + CSS3 + JS ES6        │
│  • Backend: FastAPI 0.104 + Uvicorn 0.24             │
│  • Database: PostgreSQL 14 (table: als_recos)        │
│  • ML: Apache Spark (ALS collaborative filtering)    │
│                                                       │
└───────────────────────────────────────────────────────┘
```

---

**Bon développement ! 🚀**
