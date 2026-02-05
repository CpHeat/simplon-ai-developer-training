# 🎨 Partie 3 : Maîtriser les Images et Conteneurs

**Architecture en couches et inspection**

⏱️ Durée : 10 minutes

---

**Navigation :** [🏠 Accueil](../index.md) | [Partie 1](partie1.md) | [Partie 2](partie2.md) | **Partie 3** | [Partie 4](partie4.md) | [Partie 5](partie5.md) | [Partie 6](partie6.md) | [Partie 7](partie7.md)

---

## Objectifs de cette partie

- Comprendre l'architecture en couches des images Docker
- Utiliser correctement les tags et versions
- Inspecter et debugger des images et conteneurs
- Optimiser l'utilisation du cache Docker

---

## 3.1 Anatomie d'une Image Docker

Les images Docker sont composées de **layers (couches)** empilées :

- Chaque instruction du Dockerfile crée une nouvelle couche
- Les couches sont en lecture seule et partagées entre images
- Seule la dernière couche (conteneur) est en écriture
- Système de cache pour optimiser les builds

![Docker Layers](https://docs.docker.com/build/guide/images/layers.png)

*Architecture en couches d'une image Docker*

---

## 3.2 Tags et Versions

```bash
# Format: repository:tag
docker pull python:3.11        # Version spécifique
docker pull python:3.11-slim   # Version légère
docker pull python:3.11-alpine # Version ultra-légère
docker pull python:latest      # Dernière version (à éviter en prod!)

# Taguer une image localement
docker tag mon-app:v1 mon-app:latest
docker tag mon-app:v1 registry.example.com/mon-app:v1
```

> ⚠️ **Attention :** N'utilisez jamais le tag `:latest` en production ! Spécifiez toujours une version précise pour garantir la reproductibilité.

---

## 3.3 Inspection et Debugging

```bash
# Inspecter un conteneur (format JSON)
docker inspect mon-conteneur

# Extraire une information spécifique
docker inspect -f '{{.State.Status}}' mon-conteneur
docker inspect -f '{{.NetworkSettings.IPAddress}}' mon-conteneur

# Voir les processus en cours
docker top mon-conteneur

# Voir les changements du système de fichiers
docker diff mon-conteneur

# Voir les logs avec timestamps
docker logs --timestamps mon-app

# Suivre les logs en temps réel
docker logs -f mon-app

# Inspecter la santé d'un conteneur
docker inspect --format='{{.State.Health.Status}}' mon-app
```

---

## 3.4 Comprendre les Couches

### 📝 Exemple : Analyser les couches d'une image

```bash
# Voir l'historique des couches
docker history python:3.11-slim

# Voir les couches d'une image spécifique
docker inspect python:3.11-slim | grep -A 20 "Layers"

# Analyser la taille de chaque couche
docker history --no-trunc --human python:3.11-slim
```

> 💡 **Optimisation du Cache :** Docker met en cache chaque couche. Si vous modifiez une instruction dans votre Dockerfile, toutes les couches suivantes seront reconstruites. Placez les instructions qui changent rarement au début du Dockerfile.

---

## 💡 Points clés à retenir

- Les images Docker sont composées de couches en lecture seule
- Utilisez des tags spécifiques en production, jamais `:latest`
- `docker inspect` fournit toutes les informations sur un conteneur ou une image
- Le système de cache optimise les temps de build
- Les variantes slim et alpine réduisent la taille des images

---

## Prochaine étape

Vous comprenez maintenant l'architecture des images ! Passons à la **Partie 4** pour apprendre à créer vos propres images avec Dockerfile.

---

[← Partie 2 : Premiers pas](partie2.md) | [Partie 4 : Dockerfile →](partie4.md)

---

*Formation Docker pour Data Engineering - 2024*
