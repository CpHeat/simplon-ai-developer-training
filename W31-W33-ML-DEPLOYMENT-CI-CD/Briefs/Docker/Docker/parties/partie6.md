# 🎼 Partie 6 : Docker Compose - Orchestration

**Orchestrer des applications multi-conteneurs**

⏱️ Durée : 5 minutes

---

**Navigation :** [🏠 Accueil](../index.md) | [Partie 1](partie1.md) | [Partie 2](partie2.md) | [Partie 3](partie3.md) | [Partie 4](partie4.md) | [Partie 5](partie5.md) | **Partie 6** | [Partie 7](partie7.md)

---

## Objectifs de cette partie

- Comprendre Docker Compose et ses avantages
- Écrire un fichier docker-compose.yml complet
- Orchestrer une stack Data Engineering
- Maîtriser les commandes docker-compose
- Gérer les dépendances entre services

---

## 6.1 Qu'est-ce que Docker Compose ?

**Docker Compose** est un outil pour définir et exécuter des applications Docker multi-conteneurs via un fichier YAML.

**Avantages :**

- Configuration déclarative (Infrastructure as Code)
- Gestion simplifiée de stacks complexes
- Idéal pour le développement local
- Réseaux et volumes automatiquement créés

---

## 6.2 Structure d'un docker-compose.yml

### 💼 Stack Data Engineering Complète

```yaml
version: '3.8'

services:
  # Base de données PostgreSQL
  postgres:
    image: postgres:15
    container_name: data-postgres
    environment:
      POSTGRES_DB: warehouse
      POSTGRES_USER: dataeng
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-secret}
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - data-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U dataeng"]
      interval: 10s
      timeout: 5s
      retries: 5

  # Pipeline ETL
  etl:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: etl-pipeline
    environment:
      DATABASE_URL: postgresql://dataeng:${POSTGRES_PASSWORD}@postgres:5432/warehouse
    volumes:
      - ./data:/data
      - ./logs:/app/logs
    networks:
      - data-network
    depends_on:
      postgres:
        condition: service_healthy

  # Apache Airflow
  airflow:
    image: apache/airflow:2.7.0
    ports:
      - "8080:8080"
    volumes:
      - ./dags:/opt/airflow/dags
    networks:
      - data-network

volumes:
  postgres_data:
    driver: local

networks:
  data-network:
    driver: bridge
```

---

## 6.3 Commandes Docker Compose

```bash
# Démarrer tous les services
docker-compose up -d

# Voir les logs
docker-compose logs -f

# Voir les logs d'un service spécifique
docker-compose logs -f postgres

# Arrêter les services
docker-compose down

# Arrêter et supprimer les volumes
docker-compose down -v

# Reconstruire les images
docker-compose build

# Reconstruire et démarrer
docker-compose up -d --build

# Exécuter une commande dans un service
docker-compose exec postgres psql -U dataeng

# Voir l'état des services
docker-compose ps

# Voir l'utilisation des ressources
docker-compose top

# Redémarrer un service spécifique
docker-compose restart postgres

# Voir les logs depuis le début
docker-compose logs --tail=100 etl
```

---

## 6.4 Gestion des Dépendances

Docker Compose permet de gérer l'ordre de démarrage avec `depends_on` et les healthchecks.

### 📝 Exemple : Attendre que PostgreSQL soit prêt

```yaml
services:
  postgres:
    image: postgres:15
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 3s
      retries: 5

  app:
    build: .
    depends_on:
      postgres:
        condition: service_healthy  # Attend que postgres soit sain
```

---

## 6.5 Variables d'Environnement

```bash
# Créer un fichier .env
cat << EOF > .env
POSTGRES_PASSWORD=monmotdepasse
AIRFLOW_VERSION=2.7.0
EOF

# Docker Compose charge automatiquement .env
docker-compose up -d
```

> 💡 **Bonnes pratiques :**
> - Utilisez un fichier `.env` pour les variables locales
> - Ajoutez `.env` à `.gitignore`
> - Créez un fichier `.env.example` avec des valeurs par défaut
> - Utilisez `${VARIABLE:-default}` pour des valeurs par défaut

---

## 💡 Points clés à retenir

- Docker Compose simplifie l'orchestration d'applications multi-conteneurs
- Le fichier docker-compose.yml décrit toute votre stack de manière déclarative
- `docker-compose up` démarre toute la stack d'un coup
- Les dépendances et healthchecks garantissent l'ordre de démarrage
- Utilisez des fichiers .env pour la configuration locale

---

## Prochaine étape

Vous maîtrisez maintenant Docker Compose ! Passons à la **Partie 7** pour découvrir les concepts avancés et les meilleures pratiques.

---

[← Partie 5 : Volumes et Réseaux](partie5.md) | [Partie 7 : Concepts Avancés →](partie7.md)

---

*Formation Docker pour Data Engineering - 2024*
