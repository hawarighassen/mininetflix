# 🎬 DÉMARRAGE - Lis-moi en premier !

## 🚀 TU ES PRESSÉ ? 

**Une seule commande pour TOUT lancer** :

```powershell
.\start.ps1
```

Puis suis les instructions à l'écran ! ✨

---

## 📖 TU VEUX COMPRENDRE ?

Lis les fichiers dans cet ordre :

1. **PROJET_TERMINÉ.md** ← Commence par là ! (résumé complet)
2. **QUICKSTART.md** ← 3 commandes pour démarrer
3. **README.md** ← Guide détaillé

---

## 🧪 TESTER L'API (sans frontend)

```powershell
# Test rapide
Invoke-RestMethod http://localhost:8000/health

# Recommandations aléatoires
Invoke-RestMethod "http://localhost:8000/reco/random?n=5"

# Tests automatiques complets
.\test_api.ps1
```

---

## 🌐 URLs importantes

- **API** : http://localhost:8000
- **Swagger Docs** : http://localhost:8000/docs (super utile !)
- **Frontend HTML** : http://localhost:3000
- **Frontend React** : http://localhost:5173

---

## ❓ Besoin d'aide ?

- **Problème ?** → Lis `README.md` section "Résolution de problèmes"
- **Documentation ?** → Ouvre `INDEX.md` pour voir tous les fichiers

---

**Bon développement ! 🎉**
