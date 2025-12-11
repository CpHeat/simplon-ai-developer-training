// 05_async.dart
// 🎯 Objectif : comprendre l’exécution asynchrone en Dart
// Concepts : Future, async/await, try/catch, Future.delayed.
//
// Pour exécuter le code : dart run 05_async.dart

/*
  🔹 CONTEXTE

  En Dart (et Flutter), certaines opérations prennent du temps :
  - accéder à un serveur (API, base de données…)
  - lire un fichier
  - attendre une réponse utilisateur

  Si le programme attendait ces actions *en bloquant* le fil principal,
  l’application serait figée.

  Pour éviter cela, Dart utilise un modèle **asynchrone** basé sur les *Futures*.

  Une Future représente une valeur qui n’est pas encore disponible,
  mais qui le sera plus tard — comme une *Promise* en JavaScript.

  Exemple :
      Future<String> fetchData()

  Cela signifie que la fonction renverra plus tard une chaîne de caractères.
  Tant que le résultat n’est pas prêt, le programme peut continuer à s’exécuter.
*/

import 'dart:async';

// ---------------------------------------------------------------------------
// 🔸 FONCTION ASYNCHRONE : simulation d’un chargement réseau
// ---------------------------------------------------------------------------
Future<String> getData() async {
  print("Chargement en cours...");
  // Future.delayed simule une opération lente (ex : requête HTTP)
  await Future.delayed(Duration(seconds: 2));
  return "Données reçues !";
}


// ---------------------------------------------------------------------------
// 🔸 FONCTION ASYNCHRONE QUI PEUT ÉCHOUER
// ---------------------------------------------------------------------------
Future<void> mightFail(bool fail) async {
  await Future.delayed(Duration(milliseconds: 500)); // attente simulée

  if (fail) throw Exception("Erreur réseau"); // déclenche une erreur volontaire
}


/*
  🔹 async / await

  - Le mot-clé `async` transforme une fonction en fonction asynchrone :
    → elle retourne toujours une Future.
  - Le mot-clé `await` indique qu’on veut *attendre* la fin d’une Future
    avant de passer à la suite, sans bloquer tout le programme.

  Ces deux mots-clés permettent d’écrire du code asynchrone de manière lisible,
  presque comme du code synchrone.
*/


// ---------------------------------------------------------------------------
// 🔸 FONCTION PRINCIPALE
// ---------------------------------------------------------------------------
Future<void> main() async {
  print("Début");

  // Attente du résultat de getData() avant de continuer
  final data = await getData();
  print("Données reçues : $data");

  // -------------------------------------------------------------------------
  // 🔹 GESTION D’ERREURS ASYNCHRONES
  // -------------------------------------------------------------------------
  // Comme une Future peut "échouer" (rejeter une erreur),
  // on entoure l’appel avec try/catch/finally.
  try {
    await mightFail(false); // change en true pour simuler une erreur
    print("Chemin de succès terminé");
  } catch (e) {
    print("Erreur attrapée : $e");
  } finally {
    print("Toujours exécuté à la fin");
  }

  /*
    🔹 finally
    Ce bloc s’exécute toujours :
    - après un succès
    - après une erreur
    - même si on quitte la fonction
  */

  // -------------------------------------------------------------------------
  // 🧠 À RETENIR
  // -------------------------------------------------------------------------
  // - Une Future est une promesse d’obtenir une valeur plus tard.
  // - async → indique que la fonction retourne une Future.
  // - await → "attend" une Future (sans bloquer le thread principal).
  // - try/catch/finally → gèrent les erreurs asynchrones.
  // - Future.delayed → simule ou retarde une opération asynchrone.
  //
  // Bon réflexe : toujours gérer les erreurs avec try/catch
  //   quand on utilise await sur une opération réseau ou disque.


  // -------------------------------------------------------------------------
  // 🧩 EXERCICE
  // -------------------------------------------------------------------------
  // Implémente une fonction `fetchUser(name)` qui :
  //  1) affiche "Chargement <name>..."
  //  2) attend 2 secondes
  //  3) retourne "Utilisateur(<name>)"
  //  4) Dans main(), appelle-la avec `await` et affiche le résultat.


}