# Étape 1 — Extraction automatisée des utilisateurs GitHub via API publique

## Objectif général

Vous allez développer un script Python `extract_users.py` pour extraire des données depuis l’API publique de GitHub.

Ce script devra :

- **Récupérer des utilisateurs GitHub** à partir de l’URL `https://api.github.com/users?since=<id>` (30 par 30),
- **Extraire des informations utiles** (login, id, avatar, date de création, bio),
- **Gérer automatiquement la pagination** (chaîner les appels jusqu’à atteindre un nombre défini d’utilisateurs),
- **Respecter les limitations de l’API** (quota, pause automatique si besoin),
- **Gérer les erreurs** (403, 429, 5xx...),
- **Stocker les données dans un fichier JSON clair et propre.**

---

## Étapes détaillées à suivre

### 1. Interroger l’API GitHub avec `requests`

- Faites une requête sur `https://api.github.com/users?since=0`.
- Cette requête renvoie 30 utilisateurs.
- Pour chaque utilisateur, récupérez **uniquement** :
    - `login`
    - `id`
    - `created_at`
    - `avatar_url`
    - `bio` *(si elle existe)*

**Attention** : `created_at`, `avatar_url` et `bio` ne sont pas dans la réponse de base.

Il faut interroger une deuxième URL par utilisateur : **https://api.github.com/users/<login>**

---

### 2. Authentification via token GitHub

- Créez un token personnel ici : https://github.com/settings/tokens
- Placez-le dans un fichier `.env` : GITHUB_TOKEN=xxxxxxxxxx
- Chargez-le dans le script avec `python-dotenv` :
    
    ```python
    from dotenv import load_dotenv
    import os
    
    load_dotenv()
    token = os.getenv("GITHUB_TOKEN")
    headers = {"Authorization": f"token {token}"}
    ```
    

---

### 3. Gérer les quotas de l’API GitHub

- Même avec token, GitHub limite les appels à **5000 requêtes/heure**.
- Vous devez surveiller les en-têtes HTTP de chaque réponse :
    - `X-RateLimit-Remaining`
    - `X-RateLimit-Reset`
- Si `Remaining = 0`, le script doit se mettre en **pause automatique** jusqu’à la réinitialisation du quota.

---

### 4. Pagination automatique

- Une seule requête = 30 utilisateurs
- Pour en obtenir plus (ex : 300), vous devez :
    1. Utiliser le champ `id` du **dernier utilisateur** pour générer la requête suivante
    2. Boucler jusqu’à atteindre un nombre total d’utilisateurs (par exemple : 120)

💡 Exemple : `python extract_users.py --max-users 120`

→ fera automatiquement **4 appels consécutifs** (30 x 4 = 120).

---

### 5. Gérer les erreurs HTTP

- Interceptez et gérez proprement :
    - `403 Forbidden` → problème de token ou quota dépassé
    - `429 Too Many Requests` → temporisez (délai progressif)
    - `5xx` → serveur GitHub en erreur, réessayez

Le script **ne doit jamais planter brutalement**.

---

### 6. Enregistrement des données

- Stockez les utilisateurs extraits dans un fichier : **`data/users.json`**
- Le fichier doit être :
    - bien indenté,
    - proprement structuré,
    - lisible.