Livrables attendus
À la fin du projet, chaque groupe doit remettre les éléments suivants dans un dépôt GitHub bien organisé :
1. 📁 Le projet complet versionné
Arborescence conforme :
```
tp-api-c1-c5/
├── extract_users.py
├── data/
│   ├── users.json
│   └── filtered_users.json
├── api/
│   ├── main.py
│   ├── models.py
│   ├── routes.py
│   ├── security.py
├── tests/
│   └── test_api.py  # (si réalisé)
├── requirements.txt
├── .env.example     # modèle anonymisé, sans vrai token
└── README.md
```

​
2. 📝 Un fichier README.md contenant :
Présentation du projet
Instructions pour exécuter le script d’extraction et l’API FastAPI
Commandes utiles pour lancer les tests, démarrer l’API…
Exemple de requêtes à tester (curl ou via Swagger)
Bonus : captures d’écran de l’API en fonctionnement
3. ✅ Les fichiers JSON générés
users.json : utilisateurs extraits via l’API GitHub
filtered_users.json : utilisateurs nettoyés et filtrés
4. 🔒 Le fichier .env.example
Fournir un exemple de fichier .env sans les vrais tokens
Indiquer la structure attendue, ex :
GITHUB_TOKEN=ghp_xxxxxxxx
API_ACCESS_TOKEN=secrettoken123