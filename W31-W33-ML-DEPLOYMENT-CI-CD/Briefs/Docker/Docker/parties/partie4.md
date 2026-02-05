# 📝 Partie 4 : Créer des Images avec Dockerfile

**Dockerfile, multi-stage builds et bonnes pratiques**

⏱️ Durée : 10 minutes

---

**Navigation :** [🏠 Accueil](../index.md) | [Partie 1](partie1.md) | [Partie 2](partie2.md) | [Partie 3](partie3.md) | **Partie 4** | [Partie 5](partie5.md) | [Partie 6](partie6.md) | [Partie 7](partie7.md)

---

## Objectifs de cette partie

- Comprendre la structure d'un Dockerfile
- Maîtriser les instructions essentielles
- Construire des images optimisées
- Utiliser les multi-stage builds
- Appliquer les bonnes pratiques de sécurité

---

## 4.1 Structure d'un Dockerfile

### 💼 Exemple : Application ETL Python pour Data Engineering

```dockerfile
# ============================================
# ÉTAPE 1: Image de base
# ============================================
FROM python:3.11-slim

# Métadonnées de l'image
LABEL maintainer="votre@email.com"
LABEL version="1.0"
LABEL description="Pipeline ETL pour Data Engineering"

# ============================================
# ÉTAPE 2: Configuration de l'environnement
# ============================================

# Variables d'environnement
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    APP_HOME=/app \
    DATA_DIR=/data

# Définir le répertoire de travail
WORKDIR $APP_HOME

# ============================================
# ÉTAPE 3: Installation des dépendances
# ============================================

# Installer les dépendances système
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copier requirements.txt d'abord (cache Docker)
COPY requirements.txt .

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# ============================================
# ÉTAPE 4: Copie du code source
# ============================================

# Copier le code de l'application
COPY src/ ./src/
COPY config/ ./config/
COPY etl_pipeline.py .

# ============================================
# ÉTAPE 5: Configuration finale
# ============================================

# Créer les répertoires nécessaires
RUN mkdir -p $DATA_DIR/raw $DATA_DIR/processed logs

# Créer un utilisateur non-root
RUN useradd -m -u 1000 dataeng && \
    chown -R dataeng:dataeng $APP_HOME $DATA_DIR

# Changer d'utilisateur
USER dataeng

# Exposer un port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
    CMD python -c "import sys; sys.exit(0)"

# Point de montage pour les volumes
VOLUME ["$DATA_DIR", "/app/logs"]

# Commande par défaut
CMD ["python", "etl_pipeline.py"]
```

---

## 4.2 Instructions Dockerfile

| Instruction | Description | Exemple |
|-------------|-------------|---------|
| `FROM` | Image de base | `FROM python:3.11-slim` |
| `WORKDIR` | Répertoire de travail | `WORKDIR /app` |
| `COPY` | Copier des fichiers | `COPY app.py /app/` |
| `RUN` | Exécuter commande au build | `RUN pip install pandas` |
| `CMD` | Commande par défaut | `CMD ["python", "app.py"]` |
| `ENV` | Variable d'environnement | `ENV DB_HOST=localhost` |
| `EXPOSE` | Documenter les ports | `EXPOSE 8000` |
| `VOLUME` | Point de montage | `VOLUME /data` |
| `USER` | Changer d'utilisateur | `USER dataeng` |

---

## 4.3 Construire une Image

```bash
# Build basique
docker build -t mon-app:v1 .

# Build avec tag multiple
docker build -t mon-app:v1 -t mon-app:latest .

# Build depuis un Dockerfile spécifique
docker build -f Dockerfile.dev -t mon-app:dev .

# Build avec arguments
docker build --build-arg PYTHON_VERSION=3.11 -t mon-app:v1 .

# Build sans cache
docker build --no-cache -t mon-app:v1 .
```

---

## 4.4 Multi-Stage Builds (Avancé)

Les **multi-stage builds** permettent de créer des images optimisées en séparant la compilation de l'exécution.

### 🚀 Exemple : Image Optimisée

```dockerfile
# ============================================
# STAGE 1: Builder
# ============================================
FROM python:3.11 AS builder

WORKDIR /build

# Installer les dépendances de build
RUN apt-get update && apt-get install -y gcc g++ make

# Copier et installer les dépendances
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# ============================================
# STAGE 2: Runner (image finale légère)
# ============================================
FROM python:3.11-slim

WORKDIR /app

# Copier uniquement les dépendances depuis le builder
COPY --from=builder /root/.local /root/.local

# Copier le code applicatif
COPY etl_pipeline.py .

# Ajouter les binaires au PATH
ENV PATH=/root/.local/bin:$PATH

# Utilisateur non-root
RUN useradd -m dataeng
USER dataeng

CMD ["python", "etl_pipeline.py"]

# Résultat : Image 3x plus légère !
```

---

## 📌 Bonnes Pratiques Dockerfile

- ✅ Utilisez des images de base officielles et spécifiques
- ✅ Copiez `requirements.txt` avant le code (cache)
- ✅ Regroupez les commandes RUN pour minimiser les layers
- ✅ Nettoyez les caches dans le même RUN
- ✅ N'exécutez jamais en root (utilisez USER)
- ✅ Utilisez .dockerignore
- ✅ Ajoutez des HEALTHCHECK
- ❌ Ne stockez jamais de secrets dans l'image

---

## 💡 Points clés à retenir

- Un Dockerfile décrit les instructions pour construire une image
- Chaque instruction crée une nouvelle couche
- Copiez les fichiers de dépendances avant le code pour optimiser le cache
- Les multi-stage builds réduisent drastiquement la taille des images
- N'exécutez jamais vos conteneurs en root pour la sécurité

---

## Prochaine étape

Vous savez maintenant créer vos propres images ! Passons à la **Partie 5** pour gérer les volumes, réseaux et variables d'environnement.

---

[← Partie 3 : Images et Conteneurs](partie3.md) | [Partie 5 : Volumes et Réseaux →](partie5.md)

---

*Formation Docker pour Data Engineering - 2024*
