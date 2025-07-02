# Phase 3 – Exposition via API REST (FastAPI)

Dans cette dernière phase, vous allez concevoir une **API REST** professionnelle capable d’exposer les modèles prédictifs entraînés en phase 1 (Lille) et phase 2 (Bordeaux).

L’objectif est de proposer un service d’estimation automatisé du prix au m² d’un bien immobilier, en fonction de ses caractéristiques.

---

### Objectifs

- Structurer un projet FastAPI propre, maintenable et versionné.
- Implémenter deux versions de modèle via une API REST sécurisée.
- Permettre un **A/B testing** des deux modèles pour analyse comparative.
- Faciliter l’intégration de l’API dans des services externes.

---

### Étapes attendues

1. **Initialiser un projet FastAPI** structuré :
    - `app/main.py`
    - `app/models/` : chargement des modèles
    - `app/routes/` : routes FastAPI
    - `app/schemas/` : schéma Pydantic des données en entrée
    - `tests/` : si vous avez le temps
2. **Charger les deux modèles de régression enregistrés** (`.pkl`, `.joblib`, etc.) :
    - Modèle entraîné sur Lille
    - Modèle entraîné sur Bordeaux
3. **Créer deux endpoints POST** :
    - `/predict/lille`
    - `/predict/bordeaux`
    
    Chacun prend en entrée les mêmes variables que celles utilisées pour l'entraînement :
    
    ```json
    {
        "surface_bati": 100,
        "nombre_pieces": 4,
        "type_local": "Appartement",
        "surface_terrain": 0,
        "nombre_lots": 1
    }
    ```
    
4. **Retour attendu** (exemple) :
    
    ```json
    {
        "prix_m2_estime": 3820.75,
        "ville_modele": "Lille",
        "model": "RandomForestRegressor"
    }
    ```
    
5. **Ajoutez un 3e endpoint `/predict`** qui permet de choisir dynamiquement la ville dans le payload :
    
    ```json
    {
        "ville": "bordeaux",
        "features": {
            "surface_bati": 110,
            "nombre_pieces": 4,
            "type_local": "Maison",
            "surface_terrain": 300,
            "nombre_lots": 2
        }
    }
    ```
    
6. **Gérer les erreurs de saisie** (ville inconnue, variable manquante…) avec des messages explicites.

### 📦 Livrables

- API fonctionnelle avec FastAPI
- Deux modèles prédictifs intégrés
- 3 endpoints :
    - `/predict/lille`
    - `/predict/bordeaux`
    - `/predict` (version dynamique)
- Dépôt GitHub versionné contenant :
    - Structure du projet
    - Modèles
    - Fichiers `requirements.txt` et `README.md`
    - Captures éventuelles de tests Postman si c’est fait