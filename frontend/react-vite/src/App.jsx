import { useState } from 'react'
import './App.css'

const API_URL = 'http://localhost:8000'

function App() {
    const [userId, setUserId] = useState('')
    const [numRecos, setNumRecos] = useState(10)
    const [loading, setLoading] = useState(false)
    const [error, setError] = useState('')
    const [results, setResults] = useState(null)

    const handleGetRecommendations = async () => {
        if (!userId) {
            setError('Veuillez entrer un User ID')
            return
        }

        if (numRecos < 1) {
            setError('Le nombre de recommandations doit être au moins 1')
            return
        }

        setLoading(true)
        setError('')
        setResults(null)

        try {
            const response = await fetch(`${API_URL}/reco/${userId}?n=${numRecos}`)

            if (!response.ok) {
                const errorData = await response.json()
                throw new Error(errorData.detail || 'Erreur serveur')
            }

            const data = await response.json()
            setResults(data)
        } catch (err) {
            setError(err.message)
        } finally {
            setLoading(false)
        }
    }

    const handleRandomRecommendations = async () => {
        if (numRecos < 1) {
            setError('Le nombre de recommandations doit être au moins 1')
            return
        }

        setLoading(true)
        setError('')
        setResults(null)

        try {
            const response = await fetch(`${API_URL}/reco/random?n=${numRecos}`)

            if (!response.ok) {
                const errorData = await response.json()
                throw new Error(errorData.detail || 'Erreur serveur')
            }

            const data = await response.json()
            setUserId(data.user_id)
            setResults(data)
        } catch (err) {
            setError(err.message)
        } finally {
            setLoading(false)
        }
    }

    const handleKeyPress = (e) => {
        if (e.key === 'Enter') {
            handleGetRecommendations()
        }
    }

    return (
        <div className="app">
            <div className="container">
                <h1>🎬 Mini Netflix</h1>
                <p className="subtitle">Système de recommandations BigData (ALS + Spark)</p>

                <div className="form-section">
                    <div className="input-group">
                        <div className="input-wrapper">
                            <label htmlFor="userId">👤 User ID</label>
                            <input
                                type="number"
                                id="userId"
                                placeholder="Ex: 123"
                                min="1"
                                value={userId}
                                onChange={(e) => setUserId(e.target.value)}
                                onKeyPress={handleKeyPress}
                            />
                        </div>
                        <div className="input-wrapper">
                            <label htmlFor="numRecos">🎯 Nombre de recommandations</label>
                            <input
                                type="number"
                                id="numRecos"
                                min="1"
                                max="100"
                                value={numRecos}
                                onChange={(e) => setNumRecos(e.target.value)}
                                onKeyPress={handleKeyPress}
                            />
                        </div>
                    </div>

                    <div className="button-group">
                        <button
                            className="btn-primary"
                            onClick={handleGetRecommendations}
                            disabled={loading}
                        >
                            🔍 Get Recommendations
                        </button>
                        <button
                            className="btn-secondary"
                            onClick={handleRandomRecommendations}
                            disabled={loading}
                        >
                            🎲 Random User
                        </button>
                    </div>
                </div>

                {error && (
                    <div className="error">
                        ❌ Erreur: {error}
                    </div>
                )}

                {loading && (
                    <div className="loading">
                        <div className="spinner"></div>
                        <p>Chargement des recommandations...</p>
                    </div>
                )}

                {results && !loading && (
                    <div className="results">
                        <div className="results-header">
                            <h2>📊 Recommandations</h2>
                            <p>User ID: {results.user_id} | {results.results.length} recommandation(s)</p>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>🎬 Titre du Film</th>
                                    <th>🆔 Movie ID</th>
                                    <th>⭐ Score</th>
                                </tr>
                            </thead>
                            <tbody>
                                {results.results.map((item, index) => (
                                    <tr key={item.movie_id}>
                                        <td>
                                            <span className="rank">{index + 1}</span>
                                        </td>
                                        <td><strong>{item.title}</strong></td>
                                        <td><span className="movie-id">{item.movie_id}</span></td>
                                        <td><span className="score">{item.score.toFixed(4)}</span></td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                )}
            </div>
        </div>
    )
}

export default App
