# 📜 Instructions pour l’atelier "Casse-tête"

## 📋 Contexte général
- Chacun travaille sur sa propre branche (feature-a, feature-b, feature-c).
- Modifications sur main.py, utils.py, data_loader.py.
- Résolution des conflits en équipe après push des branches.
- La branche main contient les apports de chaque membre du projet.

## 👤 Personne A - Missions

### utils.py
- Consigne : Créer une fonction qui reçoit deux nombres et retourne leur multiplication.
- Exemple attendu :
```
multiply_numbers(3, 4) → 12
```
### data_loader.py
- Consigne : Modifier load_data() pour qu’elle retourne un dictionnaire avec une liste de 3 éléments fictifs.
- Exemple attendu :
```
{'status': 'ok', 'data': ['Alice', 'Bob', 'Charlie']}
```
### main.py
- Consigne : Afficher le nombre d’éléments présents dans data.
- Exemple attendu (console) :
```
Nombre d'éléments chargés : 3
```


## 👤 Personne B - Missions

### utils.py
- Consigne : Créer une fonction qui prend un nombre et retourne son carré.
- Exemple attendu :
```
square_number(5) → 25
```
### data_loader.py
- Consigne : Créer une nouvelle fonction `load_config()` qui retourne un dictionnaire de configuration.
- Exemple attendu :
```
{'env': 'dev', 'version': '1.0'}
```
### main.py
- Consigne : Afficher le carré du result calculé grâce à `square_number()`. Ensuite afficher la config grâce à `load_config()`.
- Exemple attendu (console) :
```
Résultat au carré : 25
La config est : {'env': 'dev', 'version': '1.0'}
```


## 👤 Personne C - Missions


### utils.py
- Consigne : Créer une fonction qui prend deux nombres et retourne leur soustraction.
- Exemple attendu :
```
subtract_numbers(10, 6) → 4
```
### data_loader.py
- Consigne : Créer une fonction load_complete_data() pour qu’elle retourne aussi une clé "metadata" en plus de la data.
- Exemple attendu :
```
{
  'status': 'ok',
  'data': [],
  'metadata': {
    'author': 'Team',
    'date': '2025-04-27'
  }
}
```
### main.py
- Consigne : Afficher un message au début et un autre à la fin de l’exécution.
- Exemple attendu (console) :
```
== Début du programme ==
Résultat: 15
Data loaded: {...}
== Fin du programme ==
```
