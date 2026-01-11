# 🎬 Mini Netflix BigData - Guide de Lancement

## 📁 Structure du Projet

```
mini-netflix-bigdata/
├── api/
│   ├── 07_api_recos.py          # API FastAPI
│   └── requirements.txt          # Dépendances Python
├── frontend/
│   ├── html-pure/
│   │   └── index.html           # Version HTML/CSS/JS
│   └── react-vite/              # Version React
│       ├── src/
│       │   ├── App.jsx
│       │   ├── App.css
│       │   └── main.jsx
│       ├── index.html
│       ├── package.json
│       └── vite.config.js
├── spark/                        # Scripts Spark
├── .env
└── README.md
```

---

## 🚀 ÉTAPE 1 : Lancer l'API FastAPI

### Option A : Lancement Direct (Recommandé pour débuter)

1. **Ouvrir un terminal dans le dossier `api/`** :
   ```powershell
   cd api
   ```

2. **Installer les dépendances Python** (première fois seulement) :
   ```powershell
   pip install -r requirements.txt
   ```

3. **Lancer l'API** :
   ```powershell
   uvicorn 07_api_recos:app --reload --host 0.0.0.0 --port 8000
   ```

4. **Vérifier que ça fonctionne** :
   - Ouvrir http://localhost:8000 dans ton navigateur
   - Vérifier http://localhost:8000/health
   - Accéder à la documentation auto : http://localhost:8000/docs

### Option B : Avec Variables d'Environnement

Si tu veux utiliser `.env` pour la config PostgreSQL :

```powershell
# Créer/éditer .env dans le dossier racine
PG_HOST=localhost
PG_PORT=5432
PG_DB=postgres
PG_USER=postgres
PG_PASS=postgres
```

Puis lancer :
```powershell
cd api
pip install python-dotenv
uvicorn 07_api_recos:app --reload --host 0.0.0.0 --port 8000
```

---

## 🌐 ÉTAPE 2 : Lancer le Frontend

### Version A : HTML/CSS/JS Pur (Plus Simple)

**Super facile, pas d'installation !**

1. **Ouvrir le fichier dans ton navigateur** :
   ```powershell
   cd frontend\html-pure
   # Double-cliquer sur index.html
   # OU utiliser un serveur local :
   python -m http.server 3000
   ```

2. **Si tu utilises un serveur local** :
   - Ouvrir http://localhost:3000

**Avantage** : Aucune installation, fonctionne directement.

---

### Version B : React (Vite) - Plus Moderne

**Nécessite Node.js installé**

1. **Vérifier que Node.js est installé** :
   ```powershell
   node --version
   npm --version
   ```
   Si pas installé : [télécharger Node.js](https://nodejs.org/)

2. **Aller dans le dossier React** :
   ```powershell
   cd frontend\react-vite
   ```

3. **Installer les dépendances** (première fois seulement) :
   ```powershell
   npm install
   ```

4. **Lancer le serveur de développement** :
   ```powershell
   npm run dev
   ```

5. **Ouvrir dans le navigateur** :
   - Le terminal affichera une URL (généralement http://localhost:5173)
   - Ouvrir cette URL

**Avantage** : Interface moderne, rechargement automatique.

---

## 🧪 ÉTAPE 3 : Tester l'API (Sans Frontend)

### Test avec PowerShell (Invoke-RestMethod)

```powershell
# Test 1 : Health check
Invoke-RestMethod -Uri http://localhost:8000/health

# Test 2 : Recommandations pour user_id = 1
Invoke-RestMethod -Uri "http://localhost:8000/reco/1?n=10"

# Test 3 : Recommandations pour un user aléatoire
Invoke-RestMethod -Uri "http://localhost:8000/reco/random?n=5"
```

### Test avec curl (si installé)

```bash
# Test 1 : Health check
curl http://localhost:8000/health

# Test 2 : Recommandations
curl http://localhost:8000/reco/1?n=10

# Test 3 : Random user
curl http://localhost:8000/reco/random?n=5
```

---

## 📊 Endpoints Disponibles

| Endpoint | Méthode | Description | Exemple |
|----------|---------|-------------|---------|
| `/` | GET | Page d'accueil de l'API | http://localhost:8000/ |
| `/health` | GET | Vérification santé | http://localhost:8000/health |
| `/reco/{user_id}?n=10` | GET | Recommandations pour un user | http://localhost:8000/reco/123?n=10 |
| `/reco/random?n=10` | GET | Recommandations user aléatoire | http://localhost:8000/reco/random?n=5 |
| `/docs` | GET | Documentation Swagger auto | http://localhost:8000/docs |
| `/redoc` | GET | Documentation ReDoc | http://localhost:8000/redoc |

---

## 🎯 Utilisation du Frontend

1. **Entrer un User ID** (ex: 1, 123, 456...)
2. **Choisir le nombre de recommandations** (entre 1 et 100)
3. **Cliquer sur "Get Recommendations"** ou appuyer sur Entrée
4. **OU cliquer sur "Random User"** pour tester avec un utilisateur aléatoire

### Résultat affiché :
- **Tableau** avec : Rang, Titre du film, Movie ID, Score
- **Messages d'erreur** si problème (en rouge)
- **Loading** pendant le chargement

---

## ❌ Résolution des Problèmes Courants

### Problème 1 : "Aucune recommandation trouvée"
**Solution** : Le user_id n'existe pas dans la table `public.als_recos`
- Utiliser le bouton "Random User" pour trouver un user valide
- Vérifier dans PostgreSQL : `SELECT DISTINCT user_id FROM public.als_recos LIMIT 10;`

### Problème 2 : "Impossible de se connecter à la base de données"
**Solution** : PostgreSQL n'est pas démarré ou config incorrecte
- Vérifier que PostgreSQL tourne : `docker ps` (si Docker)
- Vérifier les credentials dans `api/07_api_recos.py` (lignes 28-32)

### Problème 3 : "CORS error" dans le navigateur
**Solution** : L'API n'est pas lancée ou mauvaise URL
- Vérifier que l'API tourne sur http://localhost:8000
- Check la console du navigateur (F12)

### Problème 4 : Caractères bizarres (É, è, à...)
**Solution** : Problème d'encodage UTF-8 (normalement résolu)
- Vérifier que PostgreSQL est en UTF-8
- L'API force déjà UTF-8 dans le code

### Problème 5 : "Module not found" (React)
**Solution** : Les dépendances ne sont pas installées
```powershell
cd frontend\react-vite
npm install
```

---

## 🔥 Workflow Complet en 3 Étapes

### ÉTAPE 1 : Lancer PostgreSQL
```powershell
# Si Docker :
docker-compose up -d postgres

# Vérifier :
docker ps
```

### ÉTAPE 2 : Lancer l'API
```powershell
cd api
pip install -r requirements.txt
uvicorn 07_api_recos:app --reload --host 0.0.0.0 --port 8000
```
✅ Vérifier : http://localhost:8000/docs

### ÉTAPE 3A : Lancer Frontend HTML (Simple)
```powershell
cd frontend\html-pure
# Double-cliquer sur index.html
```

### ÉTAPE 3B : Lancer Frontend React (Moderne)
```powershell
cd frontend\react-vite
npm install
npm run dev
```
✅ Ouvrir : http://localhost:5173

---

## 🎁 Bonus : Tester avec Swagger Docs

1. **Ouvrir** : http://localhost:8000/docs
2. **Cliquer** sur un endpoint (ex: `/reco/{user_id}`)
3. **Cliquer** sur "Try it out"
4. **Entrer** les paramètres (user_id, n)
5. **Cliquer** sur "Execute"
6. **Voir** le résultat directement dans le navigateur

**Super pratique pour tester sans frontend !**

---

## 📸 Capture d'Écran du Résultat Attendu

**Frontend** :
- Formulaire avec 2 champs + 2 boutons
- Tableau avec les films recommandés
- Design moderne (gradient violet/bleu)

**API Swagger** :
- Documentation interactive
- Possibilité de tester tous les endpoints

---

## 🎓 Explications pour Débutants

### Qu'est-ce qu'une API ?
- C'est comme un **serveur de restaurant** : tu lui demandes quelque chose, il te le donne
- Ici, tu demandes "donne-moi les films pour user 123"
- L'API va chercher dans PostgreSQL et te renvoie du JSON

### Qu'est-ce que FastAPI ?
- Un **framework Python** pour créer des APIs super rapidement
- Génère automatiquement la documentation (`/docs`)
- Très rapide et moderne

### Qu'est-ce que React/Vite ?
- **React** : bibliothèque JavaScript pour créer des interfaces
- **Vite** : outil pour développer React super rapidement (rechargement instantané)

### Qu'est-ce que CORS ?
- **Cross-Origin Resource Sharing**
- Permet au frontend (localhost:5173) d'appeler l'API (localhost:8000)
- Sans CORS, le navigateur bloque les appels

### Qu'est-ce que UTF-8 ?
- **Encodage de caractères** pour gérer les accents (é, è, à, ç...)
- Important pour afficher correctement les titres de films français

---

## 📝 Checklist de Validation

- [ ] PostgreSQL est lancé et accessible
- [ ] Table `public.als_recos` contient des données
- [ ] API répond sur http://localhost:8000/health
- [ ] Documentation Swagger fonctionne : http://localhost:8000/docs
- [ ] Frontend HTML s'ouvre dans le navigateur
- [ ] OU Frontend React lance sans erreur
- [ ] Bouton "Get Recommendations" affiche un tableau
- [ ] Bouton "Random User" fonctionne
- [ ] Les titres de films s'affichent correctement (accents OK)
- [ ] Les erreurs sont affichées en rouge si user inconnu

---

## 🎉 Félicitations !

Tu as maintenant un **système complet de recommandations** :
- ✅ Backend BigData (Spark ALS)
- ✅ Base de données (PostgreSQL)
- ✅ API REST (FastAPI)
- ✅ Frontend web (HTML ou React)

**Le projet est terminé !** 🚀

---

## 📚 Pour Aller Plus Loin

### Améliorations possibles :
1. **Authentification** : ajouter des tokens JWT
2. **Cache** : utiliser Redis pour accélérer
3. **Déploiement** : mettre en ligne sur Heroku/AWS
4. **Dashboard** : ajouter des graphiques avec les stats
5. **Filtres** : filtrer par genre, année, etc.

### Technologies à explorer :
- **FastAPI** : https://fastapi.tiangolo.com/
- **React** : https://react.dev/
- **Vite** : https://vitejs.dev/
- **Spark ML** : https://spark.apache.org/mllib/

---

**Auteur** : Mini Netflix BigData Project  
**Date** : Janvier 2026  
**Niveau** : LBI 1ère année (adapté débutants)
