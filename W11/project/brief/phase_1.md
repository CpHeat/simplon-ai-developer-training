# Phase 1 — Modélisation du prix au m² à Lille (2022) pour les logements de 4 pièces

Dans cette première phase, vous allez construire un **modèle de prédiction du prix au m²** à partir de données issues des **ventes immobilières à Lille**, en vous concentrant sur les **logements de 4 pièces** vendus en **2022**.

Deux études séparées seront menées :

- L’une sur les **appartements**
- L’autre sur les **maisons**

---

### Objectifs

- Comprendre les relations entre certaines caractéristiques des biens (surface, nombre de lots, etc.) et leur prix au m²
- Comparer les dynamiques de prix entre appartements et maisons
- Mettre en œuvre un pipeline de modélisation supervisée
- Sélectionner les modèles les plus performants par type de bien
- Poser les bases d’un futur service d’estimation différencié par catégorie de logement

---

### Consignes

1. **Charger les données** depuis le fichier `data/lille_2022.csv`
2. **Filtrer les biens de 4 pièces uniquement** : `Nombre pieces principales == 4`
3. **Créer deux jeux de données distincts** :
    - Un jeu avec uniquement les **appartements**
    - Un jeu avec uniquement les **maisons**
4. Pour chaque jeu, ne conservez que les colonnes suivantes :
    - `Surface reelle bati`
    - `Nombre pieces principales`
    - `Type local`
    - `Surface terrain` (si disponible)
    - `Nombre de lots`
    - `Valeur fonciere` (pour calculer le `prix_m2`)
5. **Créer la variable cible** :
    
    ```python
    prix_m2 = Valeur fonciere / Surface reelle bati
    ```
    
6. **Nettoyer les données** :
    - Supprimer les lignes avec valeurs manquantes sur les colonnes utilisées
    - Identifier et retirer les valeurs aberrantes (prix au m² trop faible ou trop élevé)

**7. Préparer les données pour l'entraînement**

- Variables explicatives : `X`
- Variable cible : `y = prix_m2`
- Division en jeu d'entraînement (80%) et test (20%) avec `train_test_split`

**8. Entraîner les modèles de base avec `scikit-learn`**

- `LinearRegression`
- `DecisionTreeRegressor`
- `RandomForestRegressor`

**9. Optimiser les modèles d’arbres avec `GridSearchCV`**

- Appliquer une recherche d’hyperparamètres sur les arbres pour améliorer les résultats

**10. Ajouter un modèle moderne : `XGBRegressor`**

**Lien utile** : [https://www.ibm.com/fr-fr/think/topics/xgboost#:~:text=XGBoost (eXtreme Gradient Boosting) est,utilise la descente de gradient](https://www.ibm.com/fr-fr/think/topics/xgboost#:~:text=XGBoost%20(eXtreme%20Gradient%20Boosting)%20est,utilise%20la%20descente%20de%20gradient)

- Utilisé aujourd’hui dans de nombreux projets industriels
- Formation avec les mêmes données d'entraînement
- Prédiction et évaluation sur les données de test

**11. Évaluer les performances de tous les modèles**

- Utiliser la métrique **MSE** (`mean_squared_error`)
- Comparer les performances de tous les modèles testés
- Afficher un **tableau comparatif clair** pour :
    - les **appartements**
    - les **maisons**