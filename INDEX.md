# 🎬 Mini Netflix BigData - INDEX

Bienvenue ! Voici tous les fichiers créés pour toi :

## 📂 Fichiers du Projet

### 🚀 Pour démarrer rapidement
1. **QUICKSTART.md** - 3 commandes pour tout lancer
2. **start.ps1** - Script automatique PowerShell
3. **test_api.ps1** - Tests automatiques

### 📖 Documentation complète
1. **README.md** - Guide complet (commandes, explications, résolution de problèmes)
2. **SUMMARY.md** - Résumé du projet (checklist, technos, FAQ)
3. **ARCHITECTURE.md** - Architecture technique détaillée
4. **VISUAL_GUIDE.md** - Guide visuel avec ASCII art
5. **INDEX.md** - Ce fichier

### 💻 Code du Projet

#### Backend (API)
- `api/07_api_recos.py` - API FastAPI (5 endpoints)
- `api/requirements.txt` - Dépendances Python

#### Frontend HTML Pur
- `frontend/html-pure/index.html` - Tout-en-un (HTML + CSS + JS)

#### Frontend React
- `frontend/react-vite/src/App.jsx` - Composant principal
- `frontend/react-vite/src/App.css` - Styles
- `frontend/react-vite/src/main.jsx` - Point d'entrée
- `frontend/react-vite/package.json` - Config npm
- `frontend/react-vite/vite.config.js` - Config Vite
- `frontend/react-vite/index.html` - HTML de base

#### Config
- `.gitignore` - Fichiers à ignorer Git

---

## 🎯 Par où commencer ?

### Débutant absolu
1. Lire **QUICKSTART.md** (5 minutes)
2. Exécuter `.\start.ps1`
3. Suivre les instructions

### Développeur
1. Lire **README.md** (sections importantes)
2. Lancer manuellement API + Frontend
3. Tester avec **test_api.ps1**

### Expert / Prof
1. Lire **ARCHITECTURE.md**
2. Analyser le code (API + Frontend)
3. Personnaliser selon besoins

---

## 📋 Ordre de lecture recommandé

Pour un **étudiant LBI 1ère année** :
```
1. QUICKSTART.md       (Démarrage rapide)
2. SUMMARY.md          (Vue d'ensemble)
3. README.md           (Guide complet)
4. VISUAL_GUIDE.md     (Diagrammes)
5. ARCHITECTURE.md     (Détails techniques)
```

Pour **comprendre le code** :
```
1. api/07_api_recos.py          (Backend)
2. frontend/html-pure/index.html (Frontend simple)
3. frontend/react-vite/src/App.jsx (Frontend moderne)
```

---

## 🔧 Commandes Essentielles

### Lancement Auto (Recommandé)
```powershell
.\start.ps1
```

### Lancement Manuel

**Terminal 1 - API** :
```powershell
cd api
pip install -r requirements.txt
uvicorn 07_api_recos:app --reload
```

**Terminal 2 - Frontend** :
```powershell
# HTML :
cd frontend\html-pure
# Double-cliquer sur index.html

# OU React :
cd frontend\react-vite
npm install
npm run dev
```

### Tests
```powershell
.\test_api.ps1
```

---

## 🌐 URLs Importantes

| Service | URL |
|---------|-----|
| API | http://localhost:8000 |
| Docs Swagger | http://localhost:8000/docs |
| Frontend HTML | http://localhost:3000 |
| Frontend React | http://localhost:5173 |

---

## ❓ Questions Fréquentes

### Q: Par quel fichier commencer ?
**R:** `QUICKSTART.md` pour démarrer rapidement.

### Q: Comment lancer le projet ?
**R:** Exécuter `.\start.ps1` ou suivre `QUICKSTART.md`.

### Q: Quelle version du frontend utiliser ?
**R:** 
- **HTML** : Plus simple, pas d'installation
- **React** : Plus moderne, nécessite Node.js

### Q: L'API ne répond pas ?
**R:** Vérifier que PostgreSQL tourne et lancer l'API (`uvicorn ...`).

### Q: Les accents ne s'affichent pas ?
**R:** C'est déjà corrigé dans le code (UTF-8 forcé).

---

## 📞 Aide

Si tu es bloqué :

1. **Vérifier la checklist** dans `SUMMARY.md`
2. **Lire la section "Résolution de problèmes"** dans `README.md`
3. **Exécuter les tests** : `.\test_api.ps1`
4. **Vérifier les logs** dans le terminal de l'API

---

## 🎓 Concepts Clés Expliqués

| Concept | Fichier | Section |
|---------|---------|---------|
| Architecture globale | ARCHITECTURE.md | "Flux de Données" |
| Endpoints API | README.md | "Endpoints Disponibles" |
| Frontend (React vs HTML) | SUMMARY.md | "Qu'est-ce que chaque fichier fait ?" |
| Tests | VISUAL_GUIDE.md | "Tests PowerShell" |
| Déploiement | ARCHITECTURE.md | "Déploiement" |

---

## 🎨 Fichiers Markdown

| Fichier | Taille | Pour qui ? | Priorité |
|---------|--------|------------|----------|
| QUICKSTART.md | Court | Tous | ⭐⭐⭐ |
| SUMMARY.md | Moyen | Débutants | ⭐⭐⭐ |
| README.md | Long | Développeurs | ⭐⭐ |
| ARCHITECTURE.md | Long | Avancés | ⭐ |
| VISUAL_GUIDE.md | Moyen | Visuels | ⭐⭐ |
| INDEX.md | Court | Orientation | ⭐⭐⭐ |

---

## ✅ Checklist de Validation

Avant de dire "c'est terminé" :

### Backend
- [ ] API répond sur http://localhost:8000/health
- [ ] `/docs` affiche Swagger
- [ ] `/reco/random` retourne des films

### Frontend
- [ ] HTML ou React s'ouvre sans erreur
- [ ] Formulaire fonctionne
- [ ] Tableau affiche les résultats
- [ ] Bouton "Random User" fonctionne

### Tests
- [ ] `.\test_api.ps1` passe tous les tests

---

## 🚀 Next Steps

Une fois le projet lancé :

1. **Tester différents user_id**
2. **Explorer la documentation Swagger**
3. **Modifier le design du frontend**
4. **Ajouter de nouvelles fonctionnalités** (voir ARCHITECTURE.md → Roadmap)

---

## 📚 Ressources Externes

- **FastAPI** : https://fastapi.tiangolo.com/
- **React** : https://react.dev/
- **Vite** : https://vitejs.dev/
- **Spark ML** : https://spark.apache.org/mllib/

---

**Projet créé : Janvier 2026**  
**Version : 1.0.0**  
**Auteur : Mini Netflix BigData**

🎉 **Bon développement !**
