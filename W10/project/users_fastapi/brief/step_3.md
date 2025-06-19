# Étape 3 — Création d’une API REST pour exposer les utilisateurs filtrés

Maintenant que vos données ont été nettoyées et filtrées (étape 2), vous allez créer une API REST permettant d’accéder à ces utilisateurs de manière sécurisée.

L’objectif est de simuler une API interne destinée à d'autres développeurs de votre entreprise. Cette API doit permettre de consulter la liste des utilisateurs, d’obtenir les détails d’un utilisateur spécifique, et d’effectuer des recherches par mot-clé.

Vous utiliserez pour cela **FastAPI**, un framework Python léger et moderne pour la création d’API web.

---

### 🔧 Travail attendu

1. **Initialisez votre application FastAPI dans un dossier `api/`**

Structure minimale attendue :

```
api/
├── main.py          # Lancement de l’API
├── routes.py        # Définition des endpoints
├── models.py        # Schémas Pydantic
└── security.py      # Gestion de l’authentification
```

---

1. **Chargez les données depuis `data/filtered_users.json`**
- Ces données ont été produites à l’étape 2.
- Chargez-les **une seule fois** au démarrage de l’API (ne rechargez pas à chaque requête).

---

1. **Implémentez les routes suivantes :**

| Méthode | Endpoint | Fonction attendue |
| --- | --- | --- |
| GET | `/users/` | Retourne la liste complète des utilisateurs filtrés |
| GET | `/users/{login}` | Retourne les détails d’un utilisateur (recherche exacte sur le champ login) |
| GET | `/users/search?q=...` | Retourne les utilisateurs dont le login contient le mot-clé spécifié,  |

Le mot-clé peut correspondre à :

- une **compétence** : `"dev"`, `"ai"`, `"python"`
- un **prénom ou nom** : `"john"`, `"sami"`
- une **année ou suffixe** : `"2024"`, `"pro"`, `"test"`
- ou encore un **nom d’équipe** : `"team"`, `"gh"`, `"mlops"`

Cette route permet par exemple de rechercher tous les utilisateurs dont le login contient `"ai"` en appelant : `GET /users/search?q=ai`

Toutes les réponses doivent être au format JSON, proprement structurées.

---

1. **Ajoutez une sécurité via authentification HTTP Basic**

Chaque requête vers l’API doit nécessiter une **authentification par identifiant et mot de passe**.

- Utilisez le système **HTTP Basic Auth** de FastAPI (`fastapi.security.HTTPBasic`).
- Un ou plusieurs comptes utilisateurs peuvent être définis dans un fichier `.env` ou dans un dictionnaire Python (exemple : `admin` / `admin123`).
- Si les identifiants ne sont pas valides, l’API doit retourner une **erreur 401 Unauthorized**.

**Exemple d’en-tête attendu par l’API :** Authorization: Basic YWRtaW46YWRtaW4xMjM=

**Implémentez la logique d’authentification dans** `security.py`.

---

1. **Générez automatiquement la documentation de l’API**

FastAPI fournit une interface Swagger disponible à l’adresse : http://localhost:8000/docs

- Chaque route doit comporter un `summary` et une `description` pour guider les utilisateurs.
- L’authentification est prise en compte dans l’interface Swagger : un encart apparaîtra pour tester les routes protégées.

---

### Fonctionnement attendu

- L’API doit se lancer avec la commande :
    
    ```bash
    uvicorn main:app --reload
    ```
    
- Les données doivent être **accessibles uniquement si l’utilisateur est correctement authentifié**.
- Toute requête :
    - sans identifiant,
    - avec un identifiant incorrect,
    - ou vers un utilisateur inexistant
        
        doit renvoyer une **réponse claire avec le bon code HTTP** (`401`, `404`, etc.).
        

---

### Exemple de requête à tester

```bash
curl -u admin:admin123 http://localhost:8000/users/mojombo
```

Cette requête doit retourner les informations de l’utilisateur `mojombo` si celui-ci figure dans `filtered_users.json`.