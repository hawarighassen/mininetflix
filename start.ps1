# Script de lancement automatique - Mini Netflix BigData
# Usage: .\start.ps1

Write-Host "🎬 Mini Netflix BigData - Démarrage automatique" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier si PostgreSQL répond
Write-Host "1️⃣  Vérification de PostgreSQL..." -ForegroundColor Yellow
try {
    $pgTest = Invoke-Expression "docker ps --filter name=postgres --format '{{.Names}}'"
    if ($pgTest) {
        Write-Host "   ✅ PostgreSQL est lancé (Docker)" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  PostgreSQL (Docker) non détecté - assurez-vous qu'il tourne" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ℹ️  Docker non trouvé - PostgreSQL local ?" -ForegroundColor Blue
}

Write-Host ""

# Lancer l'API
Write-Host "2️⃣  Lancement de l'API FastAPI..." -ForegroundColor Yellow
$apiPath = Join-Path $PSScriptRoot "api"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$apiPath'; Write-Host '🚀 Installation des dépendances...' -ForegroundColor Cyan; pip install -q -r requirements.txt; Write-Host '✅ Lancement de l''API sur http://localhost:8000' -ForegroundColor Green; uvicorn 07_api_recos:app --reload --host 0.0.0.0 --port 8000"

Write-Host "   ✅ API lancée dans un nouveau terminal" -ForegroundColor Green
Write-Host "   📖 Documentation : http://localhost:8000/docs" -ForegroundColor Blue
Write-Host ""

# Attendre que l'API démarre
Write-Host "⏳ Attente du démarrage de l'API (5 secondes)..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Proposer le choix du frontend
Write-Host ""
Write-Host "3️⃣  Choix du Frontend :" -ForegroundColor Yellow
Write-Host "   [1] HTML/CSS/JS Pur (Simple - pas d'installation)" -ForegroundColor White
Write-Host "   [2] React + Vite (Moderne - nécessite Node.js)" -ForegroundColor White
Write-Host "   [3] Les deux" -ForegroundColor White
Write-Host "   [4] Aucun (juste l'API)" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Votre choix (1-4)"

switch ($choice) {
    "1" {
        Write-Host "   🌐 Lancement frontend HTML..." -ForegroundColor Cyan
        $htmlPath = Join-Path $PSScriptRoot "frontend\html-pure"
        Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$htmlPath'; Write-Host '🌐 Serveur HTTP sur http://localhost:3000' -ForegroundColor Green; python -m http.server 3000"
        Write-Host "   ✅ Frontend HTML : http://localhost:3000" -ForegroundColor Green
    }
    "2" {
        Write-Host "   ⚛️  Lancement frontend React..." -ForegroundColor Cyan
        $reactPath = Join-Path $PSScriptRoot "frontend\react-vite"
        Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$reactPath'; Write-Host '📦 Installation des dépendances...' -ForegroundColor Cyan; npm install; Write-Host '⚛️  Lancement React + Vite' -ForegroundColor Green; npm run dev"
        Write-Host "   ✅ Frontend React : http://localhost:5173 (après installation)" -ForegroundColor Green
    }
    "3" {
        Write-Host "   🌐 Lancement frontend HTML..." -ForegroundColor Cyan
        $htmlPath = Join-Path $PSScriptRoot "frontend\html-pure"
        Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$htmlPath'; Write-Host '🌐 Serveur HTTP sur http://localhost:3000' -ForegroundColor Green; python -m http.server 3000"
        
        Write-Host "   ⚛️  Lancement frontend React..." -ForegroundColor Cyan
        $reactPath = Join-Path $PSScriptRoot "frontend\react-vite"
        Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$reactPath'; Write-Host '📦 Installation des dépendances...' -ForegroundColor Cyan; npm install; Write-Host '⚛️  Lancement React + Vite' -ForegroundColor Green; npm run dev"
        
        Write-Host "   ✅ Frontend HTML : http://localhost:3000" -ForegroundColor Green
        Write-Host "   ✅ Frontend React : http://localhost:5173" -ForegroundColor Green
    }
    "4" {
        Write-Host "   ℹ️  Pas de frontend - utiliser http://localhost:8000/docs" -ForegroundColor Blue
    }
    default {
        Write-Host "   ⚠️  Choix invalide - pas de frontend lancé" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "✅ DÉMARRAGE TERMINÉ !" -ForegroundColor Green
Write-Host ""
Write-Host "📌 URLs importantes :" -ForegroundColor Cyan
Write-Host "   • API : http://localhost:8000" -ForegroundColor White
Write-Host "   • Docs Swagger : http://localhost:8000/docs" -ForegroundColor White
Write-Host "   • Health Check : http://localhost:8000/health" -ForegroundColor White
if ($choice -eq "1" -or $choice -eq "3") {
    Write-Host "   • Frontend HTML : http://localhost:3000" -ForegroundColor White
}
if ($choice -eq "2" -or $choice -eq "3") {
    Write-Host "   • Frontend React : http://localhost:5173" -ForegroundColor White
}
Write-Host ""
Write-Host "🧪 Test rapide :" -ForegroundColor Cyan
Write-Host '   Invoke-RestMethod -Uri "http://localhost:8000/reco/random?n=5"' -ForegroundColor Gray
Write-Host ""
Write-Host "🛑 Pour arrêter : Fermer les terminaux ou Ctrl+C" -ForegroundColor Yellow
Write-Host ""
