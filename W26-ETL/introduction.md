# ETL Automation - Airflow - 4 days training

# Cours

https://www.canva.com/design/DAG1SbPU_YY/-8dQ3S4NjnefGBzTCSezTA/edit?utm_content=DAG1SbPU_YY&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton

# Pratique

### 1. Installation et configuration de Apache Airflow via ce guide :

**MAC** :

https://blog.stephane-robert.info/docs/services/scheduling/apache-airflow/

**L’accès au panel web se fait sur le port 8080**

**LINUX** : 

https://docs.vultr.com/how-to-install-apache-airflow-on-ubuntu-24-04

**Windows** 

WSL2, Docker ou VM Ubuntu

---

### 2. Entrainement :

**2.1. Dans ce 1er tutoriel, vous allez créer votre premier DAG :** 

https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html

---

**2.2.** Dans le 1er tutoriel, vous avez créé votre premier DAG Airflow en utilisant des opérateurs classiques comme le BashOperator.
**Dans ce nouveau tuto, vous allez créer un pipeline ETL** simple — Extraire → Transformer → Charger — en utilisant la TaskFlow API

**Tuto :** 

https://airflow.apache.org/docs/apache-airflow/stable/tutorial/taskflow.html 

---

**2.3.** Après avoir créé votre 1er **DAG** et utilisé des opérateurs de base, vous allez construire un **pipeline de données complet** : il **télécharge un fichier CSV**, le **charge dans une base Postgres**, puis **nettoie et met à jour les données**.

Vous découvrirez le **SQLExecuteQueryOperator**, une méthode moderne pour **exécuter du SQL dans Airflow**, ainsi que la configuration d’une **connexion Postgres** via l’**interface Airflow**.

À la fin, vous aurez un pipeline fonctionnel et une meilleure maîtrise de :

- L’interface et le système de connexions d’Airflow
- L’exécution de requêtes SQL
- La création de DAGs clairs et maintenables

**Tuto** : 

https://airflow.apache.org/docs/apache-airflow/stable/tutorial/pipeline.html

---

### 2. Mini projet

**Objectifs :** 

Ce Lab vous montre **comment orchestrer un pipeline ML existant avec Airflow**. Le cœur pédagogique du lab, c’est **l’automatisation du workflow**, pas la conception du modèle.

Le fichier `model_development.py` contient **le modèle ML prêt à être exécuté**

(une **régression logistique** sur `advertising.csv`).

Ce script fait par exemple :

- le chargement du dataset,
- la séparation train/test,
- l’entraînement du modèle,
- la sauvegarde du modèle entraîné dans `/model/`.

Vos mission, c’est :

1. **Créer les tâches Airflow** (`PythonOperator`, `BashOperator`, `EmailOperator`, etc.)
    
    qui vont exécuter les fonctions du script déjà existant (`load_data()`, `build_model()`, etc.)
    
2. **Gérer les dépendances** entre ces tâches (ex. `load_data` → `preprocess` → `train` → `evaluate`)
3. **Configurer les notifications par mail**
4. **Relier le tout à la mini-API Flask** qui affiche le statut du DAG

> Le but est d’apprendre à industrialiser un workflow de ML, pas à inventer le modèle.
> 
1. Supervision du workflow

**Le lien du Lab avec le Github** 

https://www.mlwithramin.com/blog/airflow-lab2 + https://github.com/raminmohammadi/MLOps/tree/main/Labs/Airflow_Labs/Lab_2

**NB :** Vous n’êtes pas obligé de faire le lab 1 comme mentionné dans l’article, le lab1 vous servira de base pour structurer votre projet correctement.

---

### Livrables

- Lien GitHub du projet complet
- README documenté
- Captures d’écran des résultats
- Fichier `.pdf` de synthèse avec les captures et le résumé du fonctionnement

---

### Optionnel-Pour aller plus loin :

[Déploiement complet d’un environnement Airflow sur une VM dans le cloud](https://www.notion.so/D-ploiement-complet-d-un-environnement-Airflow-sur-une-VM-dans-le-cloud-29335f447c78800fb12ffe301d78374c?pvs=21)

---

[AZURE DATA FACTORY](https://www.notion.so/AZURE-DATA-FACTORY-29535f447c7880b5a8ede7dbce6650bc?pvs=21)