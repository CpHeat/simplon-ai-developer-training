# Phase 2 : Test de généralisation sur Bordeaux

### Objectif

Tester la robustesse et la capacité de généralisation des modèles construits sur **Lille**, en les appliquant à une autre ville : **Bordeaux**, pour les **logements de 4 pièces**, vendus en **2022**.

Deux cas seront analysés séparément :

- **Appartements uniquement**
- **Maisons uniquement**

---

### Consignes

1. **Charger les données de Bordeaux** depuis le fichier `data/bordeaux_2022.csv`.
2. **Appliquer exactement le même filtrage que pour Lille.**
3. **Séparer les logements en deux catégories** :
    - **Appartements**
    - **Maisons**
4. **Pour chaque catégorie, effectuer les mêmes préparations que dans la phase 1** :
    - Calculer `prix_m2 = Valeur fonciere / Surface reelle bati`
    - Conserver uniquement les colonnes suivantes :
        - `Surface reelle bati`
        - `Nombre pieces principales`
        - `Type local`
        - `Surface terrain`
        - `Nombre de lots`
    - Nettoyage des données (valeurs manquantes, outliers)
5. **Réutiliser les modèles entraînés sur Lille (phase 1)** :
    - **Ne pas réentraîner les modèles**
    - Appliquer directement les modèles (un pour les appartements, un pour les maisons)
    - Prédire les `prix_m2` sur les données de Bordeaux
    - Calculer la **MSE** pour chaque prédiction
6. **Comparer les performances entre Lille et Bordeaux pour chaque type de logement** :
    - Le modèle est-il aussi performant sur Bordeaux ?
    - Quels écarts de performance observez-vous ?
    - Quels facteurs peuvent expliquer ces différences ?
    - Le modèle généralise-t-il mieux sur un type de bien que sur l'autre ?