# 💾 Partie 5 : Volumes, Réseaux et Variables

**Persistance des données et communication inter-conteneurs**

⏱️ Durée : 5 minutes

---

**Navigation :** [🏠 Accueil](../index.md) | [Partie 1](partie1.md) | [Partie 2](partie2.md) | [Partie 3](partie3.md) | [Partie 4](partie4.md) | **Partie 5** | [Partie 6](partie6.md) | [Partie 7](partie7.md)

---

## Objectifs de cette partie

- Comprendre la persistance des données avec les volumes
- Utiliser les différents types de volumes Docker
- Créer et gérer des réseaux Docker
- Configurer des variables d'environnement
- Assurer la sécurité des données sensibles

---

## 5.1 Volumes Docker - Persistance des Données

Par défaut, les données dans un conteneur sont **éphémères**. Les **volumes** permettent de persister les données.

| Type | Description | Usage |
|------|-------------|-------|
| **Named Volume** | Géré par Docker | Bases de données, fichiers applicatifs |
| **Bind Mount** | Dossier de l'hôte monté | Développement, configuration, logs |
| **tmpfs Mount** | En mémoire (temporaire) | Données sensibles, cache |

```bash
# Créer un volume nommé
docker volume create postgres_data

# Lister les volumes
docker volume ls

# Utiliser un volume nommé
docker run -d -v postgres_data:/var/lib/postgresql/data postgres:15

# Bind mount (développement)
docker run -d -v $(pwd)/data:/app/data mon-app

# Bind mount en lecture seule
docker run -d -v $(pwd)/config:/app/config:ro mon-app

# Supprimer un volume
docker volume rm postgres_data

# Supprimer tous les volumes non utilisés
docker volume prune
```

### 💼 Cas d'usage : Persister les données d'une base PostgreSQL

```bash
# Créer un volume pour PostgreSQL
docker volume create pgdata

# Lancer PostgreSQL avec le volume
docker run -d \
  --name postgres \
  -e POSTGRES_PASSWORD=secret \
  -v pgdata:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:15

# Les données survivent à la suppression du conteneur !
docker rm -f postgres
docker run -d --name postgres -v pgdata:/var/lib/postgresql/data postgres:15
```

---

## 5.2 Réseaux Docker

Les **réseaux Docker** permettent aux conteneurs de communiquer entre eux de manière isolée.

```bash
# Créer un réseau personnalisé
docker network create data-network

# Lister les réseaux
docker network ls

# Connecter un conteneur à un réseau
docker run -d --name postgres --network data-network postgres:15
docker run -d --name app --network data-network mon-app

# Les conteneurs peuvent communiquer par leur nom !
# L'app peut accéder à PostgreSQL via "postgres:5432"

# Inspecter un réseau
docker network inspect data-network

# Supprimer un réseau
docker network rm data-network
```

### 💼 Exemple : Stack avec PostgreSQL et application

```bash
# Créer le réseau
docker network create data-net

# Lancer PostgreSQL
docker run -d \
  --name db \
  --network data-net \
  -e POSTGRES_PASSWORD=secret \
  postgres:15

# Lancer l'application (elle peut accéder à "db:5432")
docker run -d \
  --name app \
  --network data-net \
  -e DATABASE_URL=postgresql://postgres:secret@db:5432/mydb \
  mon-app:latest
```

---

## 5.3 Variables d'Environnement

```bash
# Définir une variable avec -e
docker run -e DB_HOST=localhost -e DB_PORT=5432 mon-app

# Charger depuis un fichier .env
docker run --env-file .env mon-app

# Exemple de fichier .env :
# DB_HOST=localhost
# DB_PORT=5432
# DB_NAME=warehouse
# DB_USER=dataeng
```

> ⚠️ **Sécurité :** N'utilisez jamais `-e` pour des secrets en production ! Préférez Docker Secrets ou des solutions comme HashiCorp Vault.

> 💡 **Astuce :** Utilisez `--env-file` pour séparer la configuration de votre code. Ajoutez le fichier .env à .gitignore pour ne pas commiter les secrets.

---

## 💡 Points clés à retenir

- Les volumes permettent de persister les données au-delà du cycle de vie d'un conteneur
- Utilisez des named volumes pour les données de production
- Les bind mounts sont parfaits pour le développement
- Les réseaux Docker isolent et connectent les conteneurs
- Les conteneurs sur le même réseau se découvrent par leur nom
- Ne stockez jamais de secrets dans les variables d'environnement en production

---

## Prochaine étape

Vous maîtrisez maintenant volumes et réseaux ! Passons à la **Partie 6** pour orchestrer des applications multi-conteneurs avec Docker Compose.

---

[← Partie 4 : Dockerfile](partie4.md) | [Partie 6 : Docker Compose →](partie6.md)

---

*Formation Docker pour Data Engineering - 2024*
