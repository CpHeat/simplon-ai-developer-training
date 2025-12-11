# TP Django – Créez une application de prise de rendez-vous pour un coach

### Contexte

Vous êtes sollicité·e pour développer une application web destinée à un **coach en développement personnel**.

Ce coach souhaite offrir à ses clients un système **simple, sécurisé et automatisé** de prise de rendez-vous en ligne, avec un espace personnel.

Votre mission consiste à réaliser cette application en **Python avec Django**, en vous appuyant sur les compétences acquises lors du tutoriel officiel.

---

## Objectif pédagogique

- Concevoir un projet Django structuré de bout en bout
- Créer des modèles, vues, formulaires et templates personnalisés
- Mettre en place un système d’authentification
- Appliquer des règles métiers spécifiques
- Organiser et documenter proprement un projet sur GitHub

---

## Fonctionnalités attendues

Vous devez développer les **fonctionnalités suivantes** :

### 1. **Page d’accueil**

Dans cette partie, vous allez créer une page accessible à tous les visiteurs du site, présentant le coach, ses services et ses horaires.

Pour cela, vous devrez :

- **Créer une vue dans `views.py`** : cette vue affichera la page d’accueil.
- **Créer un fichier HTML `accueil.html`** dans un dossier `templates` : ce fichier contiendra le contenu visible de la page (titre, présentation, etc.).
- **Définir une URL dans `urls.py`** de votre application pour que cette page soit accessible à l’adresse `/`.
- **Créer ou réutiliser un fichier `base.html`** pour définir la structure commune du site (en-tête, menu, pied de page). La page d’accueil utilisera ce fichier comme base.
    - Le fichier `base.html` sert de **modèle principal** pour toutes les pages du site.
    
    Il contient la **structure commune** de votre site, c’est-à-dire :
    
    - l’en-tête (`<header>`) avec le nom du site ou le logo,
    - le menu de navigation (avec les liens vers l’accueil, la connexion, etc.),
    - le pied de page (`<footer>`),
    - et une **zone vide** (appelée "bloc de contenu") dans laquelle chaque page va insérer son propre contenu.
    - **Pourquoi le créer ?**
        
        Au lieu de **répéter** le même code HTML (menu, en-tête, etc.) dans chaque page (`accueil.html`, `prise_rdv.html`, etc.), vous écrivez tout **une seule fois** dans `base.html`, puis vous le **réutilisez dans chaque page**. `base.html` = squelette du site
        

Cette étape vous permet de mettre en place la première page visible du site et de structurer votre projet dès le départ.

---

### **2. Système d’authentification – Ce que vous devez faire**

Pour permettre à vos utilisateurs de s'inscrire, se connecter et accéder à un espace personnalisé selon leur rôle (client ou coach), vous devrez :

1. **Activer le système d’authentification de Django**

- Django propose déjà un système d’authentification intégré. Vous devez l’**utiliser** (ne pas le recréer) en important ses vues génériques.
- Vous allez **connecter vos pages de login, logout et inscription** à ces vues, ou en créer des versions personnalisées.

---

**2. Créer des vues personnalisées (dans `views.py`)**

- Créez une vue pour le **tableau de bord** (dashboard) du client connecté.
- Créez une vue différente pour le **coach**, où il pourra voir tous les rendez-vous.

---

3. **Créer les templates HTML nécessaires**

Vous aurez besoin de plusieurs fichiers dans votre dossier `templates` :

- `login.html` – pour la connexion
- `signup.html` – pour l'inscription
- `dashboard_client.html` – pour l'espace personnel du client
- `dashboard_coach.html` – pour l’espace du coach
- (Optionnel) `logout.html` ou une simple redirection après déconnexion

---

4. **Créer les URLs associées (dans `urls.py`)**

- Ajoutez les URLs pour la connexion (`/login/`), la déconnexion (`/logout/`), l'inscription (`/signup/`), et l’accès aux dashboards (`/dashboard/`).

---

5. **Créer les groupes ou permissions pour différencier coach et clients**

- Soit vous utilisez le **champ `is_superuser`** pour le coach,
- Soit vous créez un **groupe “coach”** dans l’admin Django, et vous affectez les utilisateurs à ce groupe.
- Ensuite, vous vérifiez dans vos vues si l’utilisateur connecté est coach ou client, pour l’**orienter vers la bonne page**.
1. **Créer un tableau de bord (`dashboard.html`)**
- À afficher après connexion
- Le contenu de cette page sera **différent selon le rôle de l’utilisateur** :
    - Un client verra ses propres rendez-vous
    - Un coach verra tous les rendez-vous, avec l’accès à l’historique

---

### 3. **Prise de rendez-vous** – Fichiers et manipulations à prévoir

Dans cette partie, vous allez permettre aux utilisateurs de **prendre rendez-vous** en ligne via un formulaire.

### Fichiers et actions à prévoir :

1. **Créer un modèle `Seance` dans `models.py`**
    - Ce modèle représentera chaque rendez-vous.
    - Il devra contenir : la date, l’heure de début, le client, l’objet de la séance, etc.
2. **Créer un formulaire personnalisé dans `forms.py`**
    - Pour permettre à l’utilisateur de choisir :
        - un jour,
        - une heure de début,
        - et de saisir l’objet de la séance.
    - C’est ici que vous allez **valider les contraintes** métier (horaires autorisés, délai de 10 minutes, chevauchements).
3. **Créer une vue dans `views.py`**
    - Cette vue affichera le formulaire et enregistrera le rendez-vous s’il est valide.
    - Elle devra filtrer les horaires disponibles en fonction des rendez-vous déjà pris.
4. **Créer un template HTML `prise_rdv.html`**
    - Cette page affichera le formulaire de prise de rendez-vous.
    - Si le formulaire est bien rempli, l’utilisateur sera redirigé vers son tableau de bord ou un message de confirmation.
5. **Définir une URL dans `urls.py`**
    - Pour rendre le formulaire de prise de rendez-vous accessible (ex : `/prendre-rdv/`)
6. **Mettre en place la logique métier**
    - Cela se fait principalement dans le formulaire (`forms.py`) ou dans la vue :
        - Empêcher deux rendez-vous au même moment
        - Bloquer les créneaux en dehors des horaires autorisés
        - Vérifier qu’il y a au moins 10 minutes entre deux rendez-vous

---

### 4. **Historique des séances (Bonus)**

- Le coach visualise la liste des séances passées avec chaque client
- Il peut **ajouter des notes personnelles** à chaque séance (non visibles par le client)
- Le client visualise uniquement l’historique de ses propres séances

---

## Livrables attendus

- Un **dépôt GitHub** contenant votre projet structuré
- Un fichier `README.md`

---

### Modalité d’évaluation :

**Présentation orale de l’application (15 min, avec support PPT)**

L’objectif est de développer à la fois l’aisance à l’oral, la maîtrise technique et la capacité à vulgariser son travail.

L’évaluation portera sur les points suivants :

- **Aspect technique** : structure du code, organisation Django, base de données, vues, templates, logique métier, etc.
- **Aspect fonctionnel** : déroulement d’une prise de rendez-vous, expérience utilisateur, navigation, rôles client/coach
- **Démarche projet** : justification des choix, difficultés rencontrées, gestion du temps, usage de Git/GitHub