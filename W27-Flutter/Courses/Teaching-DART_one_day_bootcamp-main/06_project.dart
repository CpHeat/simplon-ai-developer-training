// 06_project.dart
// 🎯 Mini-projet : flux de login en console avec classes + async
//
// Objectifs :
// - Lire des entrées utilisateur (stdin / stdout.write)
// - Utiliser des Futures avec async/await pour simuler du réseau
// - Structurer le code en "services" + "modèles"
// - Manipuler une logique métier simple (authentification, profil)
//
// Pour exécuter le code : dart run 06_project.dart

/*
  🔹 Contexte

  Dans une vraie app, la vérification des identifiants et la récupération
  de profil se font côté serveur (HTTP, base de données). Ici, on simule
  ces appels avec Future.delayed pour rendre visibles les notions asynchrones.

  Architecture (simplifiée) :
    main()            → orchestration du flux console
    AuthService       → service d’authentification (vérifie user/pass)
    UserRepository    → service d’accès aux données utilisateur
    UserProfile       → modèle de données (DTO)
*/

import 'dart:io';
import 'dart:async';

Future<void> main() async {
  print("=== Login Simulation ===");

  // --- 1) Saisie des identifiants ---
  // On utilise readLineSync() pour lire une ligne tapée dans la console.
  // On peut aussi .trim() pour retirer les espaces/début/fin.
  stdout.write("Enter username: ");
  final username = stdin.readLineSync()?.trim();

  stdout.write("Enter password: ");
  final password = stdin.readLineSync(); // ⚠️ non masqué (limite de la console simple)

  // Vérifications minimales d’entrée (null ou vide)
  if (username == null || username.isEmpty || password == null || password.isEmpty) {
    print("Username/password required.");
    exit(1); // code de sortie non-nul = échec
  }

  // --- 2) Authentification (appel asynchrone simulé) ---
  final auth = AuthService();
  print("Checking credentials...");
  final ok = await auth.checkCredentials(username, password);

  if (!ok) {
    print("Access denied.");
    exit(1);
  }

  // --- 3) Récupération du profil (appel asynchrone simulé) ---
  final repo = UserRepository();
  print("Fetching profile...");
  final profile = await repo.fetchProfile(username);

  // --- 4) Affichage du résultat ---
  print("Welcome, ${profile.displayName}! Role=${profile.role}");
  print("Done.");
}


// ---------------------------------------------------------------------------
// 🧩 Services & Modèles
// ---------------------------------------------------------------------------

class AuthService {
  // Simule une vérification distante des identifiants
  Future<bool> checkCredentials(String user, String pass) async {
    await Future.delayed(Duration(seconds: 2)); // latence réseau simulée

    // ⚠️ Règle ultra-naïve pour la démo :
    // - mot de passe "secret"
    // - OU bien le reverse du username (ex: "alex" → "xela")
    final ok = pass == "secret" || pass == user.split('').reversed.join();
    return ok;
  }
}

class UserRepository {
  // Simule la récupération d’un profil utilisateur depuis une "source de données"
  Future<UserProfile> fetchProfile(String username) async {
    await Future.delayed(Duration(seconds: 1)); // latence simulée
    // Réponse mockée : capitalise la 1re lettre
    final display = username.isEmpty
        ? "(unknown)"
        : username[0].toUpperCase() + username.substring(1);
    return UserProfile(displayName: display, role: "student");
  }
}

// Modèle de données (DTO) simple
class UserProfile {
  final String displayName;
  final String role;
  UserProfile({required this.displayName, required this.role});

  @override
  String toString() => "UserProfile(displayName=$displayName, role=$role)";
}

// -------------------------------------------------------------------------
// 🧠 À RETENIR
// - L’IO console est bloquante, mais nos "appels serveurs" sont simulés en async.
// - On sépare responsabilités : AuthService (auth) vs UserRepository (données).
// - Un modèle (UserProfile) transporte des données propres.
// -------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// 🧩 EXERCICE
// ---------------------------------------------------------------------------
// 1) Ajouter 3 essais max pour le mot de passe.
// 2) Stocker des utilisateurs dans une Map<String, String> et vérifier contre elle.
// 3) Après login, boucle de commandes : [1] Voir profil, [2] Changer rôle, [3] Quit.
//
// 💡 Indices
//   - Pour (1) : une boucle while avec un compteur de tentatives, break si succès.
//   - Pour (2) : Map<String, String> users = {"alice":"secret", ...};
//                checkCredentials lit dans la map plutôt que d’utiliser la règle naïve.
//   - Pour (3) : do { print(menu); switch (choice) { ... } } while(choice != "3");