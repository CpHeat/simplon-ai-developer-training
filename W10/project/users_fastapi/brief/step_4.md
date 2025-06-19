# Étape 4 — Versionning Git et Documentation du projet

Vous allez maintenant finaliser votre projet en assurant une **bonne organisation, traçabilité et documentation** du code. Cette étape est essentielle dans tout projet professionnel.

---

### Travail attendu

1. **Versionner le projet complet avec Git**
    - Créez un dépôt Git local si ce n’est pas déjà fait.
    - Publiez-le sur GitHub dans un dépôt nommé par exemple : `tp-api-c1-c5`.
    - Commitez régulièrement votre avancement à chaque étape du projet.
2. **Rédiger un fichier `README.md` clair et structuré**
    
    Le fichier doit contenir :
    
    - Une brève description du projet et de son objectif
    - Une explication des **scripts** (`extract_users.py`, `filtered_users.py`, etc.)
    - Les instructions pour :
        - exécuter le script d’extraction
        - lancer l’API FastAPI
        - tester les endpoints avec exemple de requêtes (curl, Swagger…)
    - Le format attendu des requêtes et des réponses (extraits JSON)
3. **Fichier `requirements.txt`**
    - Listez toutes les bibliothèques nécessaires au projet (`requests`, `fastapi`, `python-dotenv`, `uvicorn`, etc.).
    - Ce fichier permettra à un autre développeur d’installer rapidement l’environnement avec :
        
        ```
        pip install -r requirements.txt
        ```
        

---

📂 Structure du projet attendue


```
tp-api-c1-c5/
│
├── extract_users.py            # Étape 1 : extraction brute depuis GitHub
├── filtered_users.py           # Étape 2 : nettoyage et filtrage
├── users.json                  # Données brutes
├── data/
│   └── filtered_users.json     # Données filtrées prêtes pour l’API
│
├── api/
│   ├── main.py                 # Lancement de l’API FastAPI
│   ├── models.py               # Schémas Pydantic
│   ├── routes.py               # Endpoints de l’API
│   ├── security.py             # Authentification par token (ou alternative)
│
├── tests/
│   └── test_api.py             # Tests API (bonus)
│
├── requirements.txt            # Bibliothèques à installer
├── .env                        # Token GitHub & Token API
└── README.md                   # Documentation du projet
```
