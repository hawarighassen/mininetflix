# 🚀 DÉMARRAGE RAPIDE - 3 Commandes

## ⚡ Version Ultra-Rapide (5 minutes)

### Terminal 1 : API
```powershell
cd api
pip install -r requirements.txt
uvicorn 07_api_recos:app --reload --host 0.0.0.0 --port 8000
```
✅ Vérifier : http://localhost:8000/docs

---

### Terminal 2 : Frontend HTML (Simple)
```powershell
cd frontend\html-pure
# Double-cliquer sur index.html dans l'explorateur
```
**OU avec serveur :**
```powershell
python -m http.server 3000
# Ouvrir : http://localhost:3000
```

---

### Terminal 2 : Frontend React (Moderne)
```powershell
cd frontend\react-vite
npm install
npm run dev
# Ouvrir : http://localhost:5173
```

---

## 🧪 Test Rapide API (sans frontend)

```powershell
# Test health
Invoke-RestMethod -Uri http://localhost:8000/health

# Test recommandations random
Invoke-RestMethod -Uri "http://localhost:8000/reco/random?n=10"

# Test user spécifique
Invoke-RestMethod -Uri "http://localhost:8000/reco/1?n=10"
```

---

## ✅ Checklist

- [ ] PostgreSQL lancé (`docker ps` ou service postgres)
- [ ] API répond sur port 8000
- [ ] Frontend ouvert dans le navigateur
- [ ] Bouton "Random User" fonctionne
- [ ] Tableau affiche les films

---

## 📖 Documentation Complète

Voir `README.md` pour :
- Explications détaillées
- Résolution de problèmes
- Architecture du projet
- Guide débutant
