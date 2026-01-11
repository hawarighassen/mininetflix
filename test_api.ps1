# Script de test automatique - Mini Netflix BigData
# Usage: .\test_api.ps1

Write-Host "🧪 Tests Automatiques - Mini Netflix BigData API" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""

$API_BASE = "http://localhost:8000"
$testsPassed = 0
$testsFailed = 0

# Fonction pour tester un endpoint
function Test-Endpoint {
    param(
        [string]$Name,
        [string]$Url,
        [int]$ExpectedStatus = 200
    )
    
    Write-Host "Test: $Name" -NoNewline
    
    try {
        $response = Invoke-WebRequest -Uri $Url -Method GET -ErrorAction Stop
        
        if ($response.StatusCode -eq $ExpectedStatus) {
            Write-Host " ✅ PASS" -ForegroundColor Green
            $script:testsPassed++
            return $true
        } else {
            Write-Host " ❌ FAIL (Status: $($response.StatusCode))" -ForegroundColor Red
            $script:testsFailed++
            return $false
        }
    } catch {
        Write-Host " ❌ FAIL (Error: $($_.Exception.Message))" -ForegroundColor Red
        $script:testsFailed++
        return $false
    }
}

# Fonction pour tester un endpoint et vérifier le contenu JSON
function Test-JsonEndpoint {
    param(
        [string]$Name,
        [string]$Url,
        [string]$ExpectedKey
    )
    
    Write-Host "Test: $Name" -NoNewline
    
    try {
        $response = Invoke-RestMethod -Uri $Url -Method GET -ErrorAction Stop
        
        if ($response.PSObject.Properties.Name -contains $ExpectedKey) {
            Write-Host " ✅ PASS" -ForegroundColor Green
            $script:testsPassed++
            return $response
        } else {
            Write-Host " ❌ FAIL (Key '$ExpectedKey' not found)" -ForegroundColor Red
            $script:testsFailed++
            return $null
        }
    } catch {
        Write-Host " ❌ FAIL (Error: $($_.Exception.Message))" -ForegroundColor Red
        $script:testsFailed++
        return $null
    }
}

Write-Host "🔍 Vérification préalable..." -ForegroundColor Yellow
Write-Host ""

# Vérifier si l'API est accessible
Write-Host "   Vérification de l'API sur $API_BASE..." -NoNewline
try {
    $testConnection = Invoke-WebRequest -Uri $API_BASE -Method GET -TimeoutSec 5 -ErrorAction Stop
    Write-Host " OK" -ForegroundColor Green
} catch {
    Write-Host " ERREUR" -ForegroundColor Red
    Write-Host ""
    Write-Host "❌ L'API ne répond pas sur $API_BASE" -ForegroundColor Red
    Write-Host ""
    Write-Host "Solution:" -ForegroundColor Yellow
    Write-Host "   1. Ouvrir un terminal" -ForegroundColor White
    Write-Host "   2. cd api" -ForegroundColor White
    Write-Host "   3. uvicorn 07_api_recos:app --reload --host 0.0.0.0 --port 8000" -ForegroundColor White
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "📋 Exécution des tests..." -ForegroundColor Yellow
Write-Host ""

# ========== TESTS ==========

# Test 1: Page d'accueil
Test-JsonEndpoint -Name "GET / (Page d'accueil)" -Url "$API_BASE/" -ExpectedKey "message"

# Test 2: Health check
$healthResponse = Test-JsonEndpoint -Name "GET /health (Health check)" -Url "$API_BASE/health" -ExpectedKey "status"

if ($healthResponse -and $healthResponse.status -eq "ok") {
    Write-Host "   ℹ️  Database: $($healthResponse.database)" -ForegroundColor Blue
}

# Test 3: Documentation Swagger
Test-Endpoint -Name "GET /docs (Swagger docs)" -Url "$API_BASE/docs"

# Test 4: Documentation ReDoc
Test-Endpoint -Name "GET /redoc (ReDoc docs)" -Url "$API_BASE/redoc"

# Test 5: Random recommendations
$randomResponse = Test-JsonEndpoint -Name "GET /reco/random?n=5 (Random user)" -Url "$API_BASE/reco/random?n=5" -ExpectedKey "results"

if ($randomResponse) {
    Write-Host "   ℹ️  User ID: $($randomResponse.user_id)" -ForegroundColor Blue
    Write-Host "   ℹ️  Results: $($randomResponse.results.Count) films" -ForegroundColor Blue
    
    # Vérifier que les résultats ont les bonnes clés
    if ($randomResponse.results.Count -gt 0) {
        $firstResult = $randomResponse.results[0]
        $hasTitle = $firstResult.PSObject.Properties.Name -contains "title"
        $hasScore = $firstResult.PSObject.Properties.Name -contains "score"
        $hasMovieId = $firstResult.PSObject.Properties.Name -contains "movie_id"
        
        if ($hasTitle -and $hasScore -and $hasMovieId) {
            Write-Host "   ℹ️  Exemple: '$($firstResult.title)' (score: $($firstResult.score))" -ForegroundColor Blue
        }
    }
    
    # Test 6: Recommendations pour le user trouvé
    $userId = $randomResponse.user_id
    $userResponse = Test-JsonEndpoint -Name "GET /reco/$userId (User spécifique)" -Url "$API_BASE/reco/$userId?n=10" -ExpectedKey "results"
    
    if ($userResponse) {
        Write-Host "   ℹ️  Results: $($userResponse.results.Count) films pour user $userId" -ForegroundColor Blue
    }
}

# Test 7: Paramètre n invalide (doit retourner erreur)
Write-Host "Test: GET /reco/random?n=0 (Validation n)" -NoNewline
try {
    $response = Invoke-WebRequest -Uri "$API_BASE/reco/random?n=0" -Method GET -ErrorAction Stop
    Write-Host " ❌ FAIL (Should return error for n=0)" -ForegroundColor Red
    $testsFailed++
} catch {
    if ($_.Exception.Response.StatusCode.value__ -eq 400) {
        Write-Host " ✅ PASS (Error 400 as expected)" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host " ❌ FAIL (Wrong error code)" -ForegroundColor Red
        $testsFailed++
    }
}

# Test 8: User inexistant (doit retourner 404)
Write-Host "Test: GET /reco/999999 (User inexistant)" -NoNewline
try {
    $response = Invoke-WebRequest -Uri "$API_BASE/reco/999999?n=5" -Method GET -ErrorAction Stop
    Write-Host " ⚠️  WARNING (User 999999 exists)" -ForegroundColor Yellow
} catch {
    if ($_.Exception.Response.StatusCode.value__ -eq 404) {
        Write-Host " ✅ PASS (Error 404 as expected)" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host " ❌ FAIL (Wrong error code: $($_.Exception.Response.StatusCode.value__))" -ForegroundColor Red
        $testsFailed++
    }
}

Write-Host ""
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "📊 RÉSULTATS DES TESTS" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "   ✅ Tests réussis : $testsPassed" -ForegroundColor Green
Write-Host "   ❌ Tests échoués : $testsFailed" -ForegroundColor $(if ($testsFailed -eq 0) { "Green" } else { "Red" })
Write-Host ""

$total = $testsPassed + $testsFailed
$percentage = if ($total -gt 0) { [math]::Round(($testsPassed / $total) * 100, 2) } else { 0 }

Write-Host "   Taux de réussite : $percentage%" -ForegroundColor $(if ($percentage -eq 100) { "Green" } elseif ($percentage -ge 80) { "Yellow" } else { "Red" })
Write-Host ""

if ($testsFailed -eq 0) {
    Write-Host "🎉 Tous les tests sont passés !" -ForegroundColor Green
    Write-Host ""
    Write-Host "✅ L'API fonctionne correctement" -ForegroundColor Green
    Write-Host "✅ La base de données est connectée" -ForegroundColor Green
    Write-Host "✅ Les recommandations sont accessibles" -ForegroundColor Green
    Write-Host ""
    Write-Host "🚀 Tu peux maintenant lancer le frontend !" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host "⚠️  Certains tests ont échoué" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Solutions possibles:" -ForegroundColor Yellow
    Write-Host "   1. Vérifier que PostgreSQL tourne" -ForegroundColor White
    Write-Host "   2. Vérifier que la table als_recos contient des données" -ForegroundColor White
    Write-Host "   3. Relancer l'API" -ForegroundColor White
    Write-Host ""
}

Write-Host "📖 Documentation : README.md" -ForegroundColor Blue
Write-Host ""
