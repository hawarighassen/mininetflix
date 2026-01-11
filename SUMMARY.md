# 🎯 RÉSUMÉ PROJET - Mini Netflix BigData

## ✅ Ce qui a été créé pour toi

### 1️⃣ **API FastAPI** (`api/07_api_recos.py`)
✅ Gestion UTF-8 pour les accents  
✅ CORS activé pour le frontend  
✅ 5 endpoints :
- `GET /` : Page d'accueil
- `GET /health` : Vérification santé
- `GET /reco/{user_id}?n=10` : Recommandations user
- `GET /reco/random?n=10` : User aléatoire (bonus)
- `GET /docs` : Documentation Swagger auto

✅ Messages d'erreur clairs (400, 404, 500, 503)

---

### 2️⃣ **Frontend HTML Pur** (`frontend/html-pure/index.html`)
✅ Un seul fichier (tout-en-un)  
✅ Design moderne (gradient violet/bleu)  
✅ Animations (fadeIn, shake, spinner)  
✅ Responsive (mobile-friendly)  
✅ 2 boutons :
- "Get Recommendations" : cherche par user_id
- "Random User" : user aléatoire

✅ Tableau avec : Rang, Titre, Movie ID, Score  
✅ Gestion loading + erreurs (rouge)

---

### 3️⃣ **Frontend React + Vite** (`frontend/react-vite/`)
✅ Structure moderne React  
✅ Même design que la version HTML  
✅ Hot Module Replacement (rechargement auto)  
✅ Fichiers créés :
- `src/App.jsx` : Composant principal
- `src/App.css` : Styles
- `src/main.jsx` : Point d'entrée
- `package.json` : Config npm
- `vite.config.js` : Config Vite

---

### 4️⃣ **Documentation** (3 fichiers)

#### **README.md** (Guide complet)
- Structure projet
- Commandes lancement (API + frontend)
- Tests PowerShell/curl
- Résolution problèmes
- Explications débutants
- Checklist validation

#### **QUICKSTART.md** (Démarrage rapide)
- 3 commandes pour tout lancer
- Tests rapides API
- Checklist minimale

#### **ARCHITECTURE.md** (Architecture technique)
- Flux de données complet
- Schéma base données
- Technologies utilisées
- Design patterns
- Roadmap améliorations

---

### 5️⃣ **Automatisation**

#### **start.ps1** (Script PowerShell)
✅ Lance automatiquement :
1. Vérification PostgreSQL
2. API FastAPI
3. Frontend (choix HTML ou React)

✅ Menu interactif  
✅ Affiche les URLs importantes

---

### 6️⃣ **Fichiers de config**

#### **api/requirements.txt**
```
fastapi==0.104.1
uvicorn==0.24.0
psycopg2-binary==2.9.9
python-dotenv==1.0.0
```

#### **.gitignore**
- Python (`__pycache__`, `venv`)
- Node.js (`node_modules`)
- IDE (`vscode`, `.idea`)
- OS (`.DS_Store`)

---

## 🚀 COMMENT LANCER (3 méthodes)

### Méthode 1 : Ultra-Rapide (Script auto)
```powershell
.\start.ps1
```
→ Suit les instructions à l'écran

---

### Méthode 2 : Manuel (2 terminaux)

**Terminal 1 - API** :
```powershell
cd api
pip install -r requirements.txt
uvicorn 07_api_recos:app --reload --host 0.0.0.0 --port 8000
```

**Terminal 2 - Frontend HTML** :
```powershell
cd frontend\html-pure
# Double-cliquer sur index.html
```

**OU Terminal 2 - Frontend React** :
```powershell
cd frontend\react-vite
npm install
npm run dev
```

---

### Méthode 3 : Test API seule (sans frontend)
```powershell
cd api
pip install -r requirements.txt
uvicorn 07_api_recos:app --reload

# Dans un autre terminal :
Invoke-RestMethod http://localhost:8000/reco/random?n=5
```

---

## 📊 URLs Importantes

| Service | URL | Description |
|---------|-----|-------------|
| **API** | http://localhost:8000 | Page d'accueil API |
| **Docs Swagger** | http://localhost:8000/docs | Documentation interactive |
| **ReDoc** | http://localhost:8000/redoc | Documentation alternative |
| **Health** | http://localhost:8000/health | Vérification santé |
| **Frontend HTML** | http://localhost:3000 | Interface HTML pure |
| **Frontend React** | http://localhost:5173 | Interface React |

---

## 🧪 Tests Rapides

### Test 1 : Health Check
```powershell
Invoke-RestMethod http://localhost:8000/health
```
**Résultat attendu** :
```json
{
  "status": "ok",
  "database": "connected"
}
```

---

### Test 2 : Random User
```powershell
Invoke-RestMethod "http://localhost:8000/reco/random?n=5"
```
**Résultat attendu** :
```json
{
  "user_id": 123,
  "n": 5,
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

---

### Test 3 : User Spécifique
```powershell
Invoke-RestMethod "http://localhost:8000/reco/1?n=10"
```

---

## ✅ Checklist de Validation

Avant de dire "c'est terminé", vérifie que :

### Backend
- [ ] PostgreSQL tourne (`docker ps` ou service)
- [ ] Table `public.als_recos` a des données
- [ ] `GET /health` retourne `{"status": "ok"}`
- [ ] `GET /docs` affiche Swagger
- [ ] `GET /reco/random?n=5` retourne 5 films

### Frontend HTML
- [ ] `index.html` s'ouvre sans erreur
- [ ] Champ "User ID" + "Nombre de recos" visibles
- [ ] Bouton "Get Recommendations" fonctionne
- [ ] Bouton "Random User" fonctionne
- [ ] Tableau affiche les films
- [ ] Titres avec accents s'affichent bien (é, è, à)
- [ ] Message d'erreur rouge si user inconnu

### Frontend React
- [ ] `npm install` sans erreur
- [ ] `npm run dev` lance le serveur
- [ ] Page s'ouvre sur http://localhost:5173
- [ ] Même fonctionnalités que HTML

---

## 🎯 Qu'est-ce que chaque fichier fait ?

### Backend

| Fichier | Rôle | Détail |
|---------|------|--------|
| `api/07_api_recos.py` | API principale | - Connexion PostgreSQL<br>- 5 endpoints REST<br>- CORS + UTF-8 |
| `api/requirements.txt` | Dépendances Python | Liste des packages à installer |

---

### Frontend HTML

| Fichier | Rôle | Détail |
|---------|------|--------|
| `frontend/html-pure/index.html` | Tout-en-un | - HTML structure<br>- CSS styles<br>- JS logique |

**Avantages** :
- ✅ Pas d'installation
- ✅ Fonctionne hors-ligne
- ✅ Facile à modifier

---

### Frontend React

| Fichier | Rôle | Détail |
|---------|------|--------|
| `src/App.jsx` | Composant principal | - useState (état)<br>- fetch API<br>- Rendu conditionnel |
| `src/App.css` | Styles | Design identique à HTML |
| `src/main.jsx` | Point d'entrée | Initialise React |
| `package.json` | Config npm | Dépendances + scripts |
| `vite.config.js` | Config Vite | Port + plugins |
| `index.html` | HTML de base | Div `#root` |

**Avantages** :
- ✅ Rechargement auto (HMR)
- ✅ Structure modulaire
- ✅ Prêt pour React Router, Redux...

---

### Documentation

| Fichier | Rôle | Pour qui ? |
|---------|------|------------|
| `README.md` | Guide complet | Développeurs débutants |
| `QUICKSTART.md` | Démarrage rapide | Pressés |
| `ARCHITECTURE.md` | Architecture technique | Avancés / Profs |
| `SUMMARY.md` | Ce fichier - Résumé | Tous |

---

### Automatisation

| Fichier | Rôle | Usage |
|---------|------|-------|
| `start.ps1` | Script lancement | `.\start.ps1` |
| `.gitignore` | Fichiers à ignorer | Git |

---

## 🔧 Technologies Utilisées

### Backend
- **Python 3.8+** : Langage
- **FastAPI** : Framework API REST
- **Uvicorn** : Serveur ASGI
- **psycopg2** : Driver PostgreSQL

### Frontend
- **HTML5** : Structure
- **CSS3** : Design + animations
- **JavaScript ES6+** : Logique
- **React 18** : UI library
- **Vite** : Build tool

### Infrastructure
- **PostgreSQL 14** : Base de données
- **Apache Spark** : Machine Learning (ALS)
- **Docker** : Containerisation

---

## 🎓 Explications pour Débutants (LBI 1ère année)

### 1. **API = Serveur de Restaurant**
Tu demandes quelque chose → Le serveur va chercher → Il te rapporte

**Exemple** :
- Tu demandes : "Films pour user 123"
- L'API cherche dans PostgreSQL
- L'API te renvoie la liste en JSON

---

### 2. **JSON = Format de Données**
```json
{
  "user_id": 123,
  "results": [...]
}
```
C'est comme un dictionnaire Python, mais universel (tous les langages le comprennent).

---

### 3. **Frontend ↔ Backend**
```
Frontend (HTML/React)  → fetch →  Backend (FastAPI)
      ↑                              ↓
      └───────── JSON ←──────────────┘
```

---

### 4. **CORS : Pourquoi c'est important ?**
Navigateur bloque par sécurité les appels entre domaines :
- Frontend : `localhost:5173`
- Backend : `localhost:8000`

→ CORS dit : "Oui, c'est autorisé"

---

### 5. **UTF-8 : Pourquoi on force ?**
Sans UTF-8 :
- "Café" → "CafÃ©"
- "Été" → "EtÃ©"

Avec UTF-8 :
- "Café" → "Café" ✅
- "Été" → "Été" ✅

---

### 6. **Spark ALS : Comment ça marche ?**

**Données** :
```
User 1 a noté : Film A (5★), Film B (4★)
User 2 a noté : Film B (4★), Film C (5★)
```

**Algorithme ALS** :
```
User 1 aime A et B
User 2 aime B et C
→ Probablement User 1 aimera C aussi !
```

**Résultat** :
```
Recommandations pour User 1 : [Film C (score: 0.98)]
```

---

## 🐛 Problèmes Courants & Solutions

### ❌ "Aucune recommandation trouvée"
**Cause** : user_id n'existe pas  
**Solution** : Utilise le bouton "Random User"

---

### ❌ "Database connection failed"
**Cause** : PostgreSQL pas démarré  
**Solution** :
```powershell
docker ps  # Vérifier
docker-compose up -d postgres  # Lancer
```

---

### ❌ CORS error dans le navigateur
**Cause** : API pas lancée ou mauvaise URL  
**Solution** :
1. Vérifier que l'API tourne : http://localhost:8000/health
2. Vérifier l'URL dans le frontend (`API_URL`)

---

### ❌ "Module 'fastapi' not found"
**Cause** : Dépendances pas installées  
**Solution** :
```powershell
cd api
pip install -r requirements.txt
```

---

### ❌ "npm: command not found"
**Cause** : Node.js pas installé  
**Solution** : Télécharger Node.js (https://nodejs.org/)

---

## 🎁 Bonus : Fonctionnalités Avancées

### 1. Documentation Swagger Interactive
- URL : http://localhost:8000/docs
- Tu peux **tester les endpoints** directement dans le navigateur
- Pas besoin de PowerShell ou curl !

### 2. Endpoint `/reco/random`
- Pas besoin de connaître les user_id
- Pratique pour démos

### 3. Validation automatique
- `n` doit être entre 1 et 100
- Messages d'erreur clairs si problème

### 4. Loading Spinner
- Indicateur visuel pendant le chargement
- Évite que l'utilisateur clique plusieurs fois

---

## 📈 Améliorations Futures (Si tu veux continuer)

### Court terme (facile)
1. **Filtres** : Filtrer par genre, année
2. **Tri** : Trier par score, alphabétique
3. **Recherche** : Chercher un film

### Moyen terme (intermédiaire)
1. **Authentification** : Login/logout
2. **Favoris** : Sauvegarder ses films préférés
3. **Historique** : Voir ses dernières recherches

### Long terme (avancé)
1. **Re-entraînement auto** : Mettre à jour le modèle ALS
2. **Temps réel** : WebSockets pour notifications
3. **App mobile** : React Native

---

## 📞 Aide

### Si tu es bloqué :

1. **Vérifier les logs** :
   - API : Terminal où tourne l'API
   - Frontend : Console navigateur (F12)

2. **Tester l'API directement** :
   ```powershell
   Invoke-RestMethod http://localhost:8000/health
   ```

3. **Vérifier PostgreSQL** :
   ```sql
   SELECT COUNT(*) FROM public.als_recos;
   SELECT DISTINCT user_id FROM public.als_recos LIMIT 5;
   ```

4. **Relire les docs** :
   - `README.md` : Guide complet
   - `QUICKSTART.md` : Démarrage rapide
   - `ARCHITECTURE.md` : Détails techniques

---

## 🎉 Félicitations !

Tu as maintenant un **projet full-stack complet** :

✅ **Backend** : API REST avec FastAPI  
✅ **Frontend** : 2 versions (HTML et React)  
✅ **Base de données** : PostgreSQL  
✅ **Machine Learning** : Spark ALS  
✅ **Documentation** : 4 fichiers complets  
✅ **Automatisation** : Script PowerShell

**C'est exactement ce que font les entreprises !**

---

## 📚 Ressources pour Approfondir

### API
- FastAPI : https://fastapi.tiangolo.com/
- REST API : https://restfulapi.net/

### Frontend
- React : https://react.dev/learn
- Vite : https://vitejs.dev/guide/

### Machine Learning
- Spark MLlib : https://spark.apache.org/docs/latest/ml-guide.html
- ALS : https://spark.apache.org/docs/latest/ml-collaborative-filtering.html

---

**Projet terminé ! 🚀**  
**Auteur** : Mini Netflix BigData  
**Date** : Janvier 2026
