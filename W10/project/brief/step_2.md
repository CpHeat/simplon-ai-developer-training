# Étape 2 — Structuration et filtrage des utilisateurs extraits

À ce stade, vous avez extrait de nombreux utilisateurs depuis l’API GitHub et enregistré ces données dans un fichier JSON (`data/users.json`).

Mais ces données **ne sont pas encore prêtes** à être utilisées dans une API, car :

- certaines sont **incomplètes** (bio vide, image absente),
- d’autres sont **trop anciennes** pour être pertinentes,
- ou encore **dupliquées** (même identifiant `id` plusieurs fois).

**Votre mission** maintenant : créer un petit pipeline de traitement en Python pour **nettoyer** ces données et ne conserver que les profils pertinents.

---

### Objectifs

Écrire un script Python (ou plusieurs fonctions) qui :

- lit les données du fichier `users.json`,
- supprime les doublons,
- applique des filtres métiers simples,
- et enregistre un fichier nettoyé nommé `filtered_users.json`.

Ce fichier nettoyé servira **de base pour construire votre propre API** dans l’étape suivante.

---

### Étapes à suivre

1. **Chargement du fichier**
    - Ouvrir `data/users.json`
    - Charger les données dans une variable Python (`list` de `dict`)
    - Vérifier que la structure est correcte (chaque utilisateur contient les bons champs)
2. **Suppression des doublons**
    - Certains utilisateurs peuvent apparaître plusieurs fois.
    - Supprimer tous les doublons en utilisant leur identifiant GitHub (`id`) comme clé unique.
3. **Filtrage métier**
    
    Conserver uniquement les utilisateurs qui respectent les **3 critères suivants** :
    
    - Le champ `bio` est renseigné (ni vide, ni `null`)
    - Le champ `avatar_url` est valide (pas vide)
    - Le champ `created_at` est **postérieur au 1er janvier 2015**
4. **Enregistrement des résultats**
    - Sauvegarder la liste finale dans `data/filtered_users.json`
    - Format : fichier JSON proprement indenté (lisible à l’œil)
    - Ne garder que les champs utiles : `login`, `id`, `created_at`, `avatar_url`, `bio`
5. **(Optionnel mais recommandé) Affichage d’un petit résumé**
    
    À la fin du script, affichez un mini rapport :
    
    ```bash
    
    Utilisateurs chargés : 300
    Doublons supprimés : 12
    Utilisateurs filtrés : 108
    ```
    

---

### Astuce :

Organisez votre code avec **des fonctions simples et réutilisables**, par exemple :

```python
def load_users(filepath): ...
def remove_duplicates(users): ...
def filter_users(users): ...
def save_filtered_users(users, output_path): ...
```

Cela rendra votre code plus clair, plus propre, et plus facile à tester.