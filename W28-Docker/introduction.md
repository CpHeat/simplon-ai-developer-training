# Docker

### Le cours :

https://www.canva.com/design/DAG4XuNYrRQ/bph1iBDmUyUQ3WwjaQEHyQ/edit?utm_content=DAG4XuNYrRQ&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton

---

### Installer Docker :

Utilisez le guide suivant pour installer Docker sur Mac, Linux ou Windows :

https://docs.docker.com/get-started/get-docker/

**Une fois l’installation finie, tell me** 😃 

---

### Premiers pas avec Docker (3 jours de travail)

Dans cette section, vous allez : 

### **1. Comprendre les bases de Docker :**

- Installer Docker Desktop sur votre ordinateur :

https://docs.docker.com/get-started/introduction/get-docker-desktop/ 

- Exécuter votre premier conteneur pour comprendre le principe de la conteneurisation :

https://docs.docker.com/get-started/introduction/develop-with-containers/ 

- Construire votre première image Docker :

https://docs.docker.com/get-started/introduction/build-and-push-first-image/

- Publier cette image sur Docker Hub afin de la partager et de la réutiliser :

https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-a-registry/ 

- Définir et lancer plusieurs conteneurs en même temps :

https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-docker-compose/ 

**Une fois cette section terminée, appelez-moi pour validation** 

### 2. Build images

1. **Comprendre les couches d’une image Docker :**

Vous allez comprendre comment sont construites les images Docker à partir de couches successives, comment ces couches sont réutilisées et comment créer ses propres images en modifiant et enregistrant l’état d’un conteneur : 

https://docs.docker.com/get-started/docker-concepts/building-images/understanding-image-layers/ 

1. **Écrire un Docker File :** 

Vous allez apprendre comment écrire un **Dockerfile**, le fichier qui permet de construire une image Docker. Vous allez vous familiariser avec les instructions essentielles (FROM, COPY, RUN, CMD…), puis créer une image à partir d’une application Node.js en définissant l’image de base, les dépendances et la commande de démarrage :

https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/ 

1. **Construire, nommer et publier une image Docker**

Vous allez apprendre à construire une image Docker à partir d’un Dockerfile, à lui attribuer un nom (tag) pour faciliter son identification, puis à la publier sur un registre comme Docker Hub. Vous découvrirez comment visualiser l’historique des couches de l’image, vérifier sa présence localement et la partager en ligne pour pouvoir l’utiliser ou la déployer depuis n’importe quel environnement. 

https://docs.docker.com/get-started/docker-concepts/building-images/build-tag-and-publish-an-image/ 

1. **Accélérer la construction d’images avec le cache Docker** 

Vous allez apprendre comment Docker réutilise les couches déjà construites pour éviter de tout reconstruire à chaque build. Vous allez voir comment structurer votre Dockerfile pour maximiser l’utilisation du cache, réduire le temps de compilation et éviter les reconstructions inutiles, notamment lors de l’installation des dépendances. 

https://docs.docker.com/get-started/docker-concepts/building-images/using-the-build-cache/

1. **Créer des images allégées avec les builds multi-étapes** 

Vous allez apprendre à utiliser les builds multi-étapes dans un Dockerfile afin de séparer l’environnement de compilation de l’environnement d’exécution. Cette approche permet de construire l’application dans une image complète, puis de ne copier que l’essentiel dans une image finale plus légère, plus rapide à déployer et plus sécurisée : 

https://docs.docker.com/get-started/docker-concepts/building-images/multi-stage-builds/

**Une fois cette section terminée, appelez-moi pour validation**  

### 3. BONUS (Optionnel)

Si vous voulez perfectionner votre maitrise de Docker, vous pouvez continuer votre apprentissage sur ce lien : https://docs.docker.com/get-started/introduction/whats-next/#the-basics et faire les tutos suivants : 

![Screenshot 2025-11-11 at 8.53.14 AM.png](attachment:518cb304-0f98-4b5a-8d99-37b3821d1069:Screenshot_2025-11-11_at_8.53.14_AM.png)

[Exercices de compréhension ](https://www.notion.so/Exercices-de-compr-hension-2aa35f447c788046bb32e5349a75eb20?pvs=21)

[Kahoot ](https://www.notion.so/Kahoot-2ab35f447c7880bda39dfe467851cf69?pvs=21)