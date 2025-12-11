# Phase 0 : Filtrage des données DVF

Avant de commencer la modélisation, vous devez extraire proprement les données utiles à partir du **fichier brut des valeurs foncières 2022**.

### Objectif

Créer deux jeux de données propres (`lille_2022.csv` et `bordeaux_2022.csv`) pour préparer l’analyse à venir.

### Consignes

1. **Charger le fichier DVF 2022** (`.txt` avec séparateur `|`)
2. **Filtrer les lignes** correspondant à :
    - **Commune** : `LILLE` ou `BORDEAUX`
    - **Nature mutation** : `Vente`
    - **Valeur foncière** et **Surface réelle bâtie** non nulles
3. **Convertir les colonnes** `Valeur fonciere` et `Surface reelle bati` en `float` (attention au format `virgule`)
4. **Calculer le prix au m²** pour chaque bien
5. **Exporter** les deux fichiers nettoyés dans un dossier `data/`

### Exemple de code
```
import pandas as pd
import os

# Chargement
df = pd.read_csv("ValeursFoncieres-2022.txt", sep='|', low_memory=False)

# Harmonisation
df['Commune'] = df['Commune'].str.upper()

# Filtrage LILLE
df_lille = df[
    (df['Commune'] == 'LILLE') &
    (df['Nature mutation'] == 'Vente') &
    (df['Surface reelle bati'].notna()) &
    (df['Valeur fonciere'].notna())
].copy()

# Filtrage BORDEAUX
df_bordeaux = df[
    (df['Commune'] == 'BORDEAUX') &
    (df['Nature mutation'] == 'Vente') &
    (df['Surface reelle bati'].notna()) &
    (df['Valeur fonciere'].notna())
].copy()

# Conversion en float
for df_city in [df_lille, df_bordeaux]:
    df_city['Valeur fonciere'] = df_city['Valeur fonciere'].astype(str).str.replace(',', '.').str.replace(' ', '').astype(float)
    df_city['Surface reelle bati'] = df_city['Surface reelle bati'].astype(str).str.replace(',', '.').str.replace(' ', '').astype(float)

# Calcul du prix au m²
df_lille['prix_m2'] = df_lille['Valeur fonciere'] / df_lille['Surface reelle bati']
df_bordeaux['prix_m2'] = df_bordeaux['Valeur fonciere'] / df_bordeaux['Surface reelle bati']

# Export
os.makedirs("data", exist_ok=True)
df_lille.to_csv("data/lille_2022.csv", index=False)
df_bordeaux.to_csv("data/bordeaux_2022.csv", index=False)

print("Export terminé.")
```