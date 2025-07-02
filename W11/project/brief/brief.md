# Projet Individuel — Prédiction du prix au m² en immobilier en France

### 📅 Durée : 5-6 jours | 🔧 Mode : individuel | 💻 Format : API REST + Modèle IA

**Présentation orale de 10 min sans support à la fin du projet** 

---

## Contexte

Une agence immobilière souhaite intégrer un outil d’estimation automatique du **prix au m²** dans ses applications internes. L’objectif est de mieux appuyer les décisions commerciales sur le marché immobilier des villes de **Lille** et **Bordeaux**, en s’appuyant sur les données publiques de transactions immobilières.

---

## Objectif

Concevoir un **prototype complet** combinant :

- un **modèle de machine learning** capable d’estimer le prix au m² à partir de données réelles de ventes immobilières,
- une **API REST sécurisée** développée avec **FastAPI** pour exposer ce modèle,
- une organisation de projet claire, documentée et versionnée sur GitHub.

Ce prototype devra être prêt à être testé, utilisé et intégré dans un outil métier.

---

## Ressources à utiliser

- **Dataset** :
    
    [Demandes de valeurs foncières – data.gouv.fr](https://www.data.gouv.fr/fr/datasets/demandes-de-valeurs-foncieres/) 
    
- **Méthodo ML à suivre** :
    
    [Building a basic ML model – Towards Data Science](https://towardsdatascience.com/building-a-basic-machine-learning-model-in-python-d7cca929ee62/)
    
- **Cycle de projet à respecter** :
    
    [Cycle ML en 8 étapes – Kaizen Solutions](https://kaizen-solutions.net/kaizen-insights/articles-et-conseils-de-nos-experts/cycle-de-vie-projet-machine-learning-8-etapes/)
    

---

> 😎 **Avant toute chose, prenez le temps d’analyser le dataset fournie dans lien pour l’année 2022 :** https://www.data.gouv.fr/fr/datasets/demandes-de-valeurs-foncieres/
> 

---

## Travail demandé

Vous utiliserez les **données DVF 2022** pour entraîner un modèle prédictif de prix au m², basé sur les transactions à **Lille** et à **Bordeaux**. Le projet se composera de trois phases principales : 

1. Analyse et modélisation sur Lille,
2. Extension du modèle à Bordeaux avec enrichissement,
3. Déploiement dans une API REST avec FastAPI.

[Phase 0 : Filtrage des données DVF](https://www.notion.so/Phase-0-Filtrage-des-donn-es-DVF-21735f447c7880afb870edfac5b335c0?pvs=21)

[Phase 1 — Modélisation du prix au m² à Lille (2022) pour les logements de 4 pièces](https://www.notion.so/Phase-1-Mod-lisation-du-prix-au-m-Lille-2022-pour-les-logements-de-4-pi-ces-21635f447c788051af71ed6fab5e3d81?pvs=21)

[Phase 2 : Test de généralisation sur Bordeaux ](https://www.notion.so/Phase-2-Test-de-g-n-ralisation-sur-Bordeaux-21635f447c7880cb9baaf9d29dff0e1c?pvs=21)

[Phase 3 – Exposition via API REST (FastAPI)](https://www.notion.so/Phase-3-Exposition-via-API-REST-FastAPI-21635f447c7880a5a205e79077782ced?pvs=21)

---

## 📁 Structure projet recommandée

```
immoprice-api/
│
├── data/                             # Fichiers sources (ex : lille_2022.csv, bordeaux_2022.csv)
│                                     # Ne pas pousser ce dossier sur GitHub
│
├── models/                           # Modèles sauvegardés (.pkl, .joblib)
│   ├── model_lille.pkl
│   └── model_bordeaux.pkl
│
├── notebooks/                        # Études exploratoires et modélisation
│   ├── phase_1_lille.ipynb
│   └── phase_2_bordeaux.ipynb
│
├── app/                              # Code source de l’API FastAPI
│   ├── main.py                       # Point d’entrée FastAPI, routes des prédictions
│   ├── predict.py                    # Fonctions de prédiction
│   ├── model_loader.py               # Chargement des modèles ML
│   ├── schemas.py                    # Modèles Pydantic pour validation des requêtes
│   └── utils.py                      # Prétraitement, nettoyage, encodage
│
├── tests/                            # Tests unitaires avec pytest
│   ├── test_predict_lille.py
│   └── test_predict_bordeaux.py
│
├── requirements.txt                  # Dépendances du projet
├── README.md                         # Documentation complète du projet
├── .gitignore                        # Exclusion des fichiers (ex: /data/, *.pkl)
└── .env.example                      # Exemple de fichier d’environnement (si besoin)
```

---

## Versionning Git attendu

- Projet hébergé dans un dépôt GitHub individuel
- Commits réguliers à chaque étape importante
- README clair et à jour
- Le fichier `.gitignore` doit exclure le dossier `data/` (le dataset ne doit **jamais** être poussé)

---

## Livrables à rendre

- Lien vers le dépôt GitHub
- Un **notebook propre** avec l'entraînement du modèle
- Un script ou dossier `FastAPI` prêt à être lancé
- Des **tests unitaires** valides et exécutables
- Un **README.md complet** (description, lancement, tests, structure)