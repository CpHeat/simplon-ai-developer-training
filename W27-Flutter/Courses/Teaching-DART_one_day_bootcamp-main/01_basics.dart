// 01_basics.dart
// 🎯 Objectif : découvrir la syntaxe de base de Dart en la comparant à Python ou JavaScript pour faciliter la transition.
//
// Pour exécuter le code : dart run 01_basics.dart

import 'dart:io';

/*
  🔹 Contexte

  Dart est un langage moderne orienté objet, utilisé notamment pour Flutter.
  Il est fortement typé (comme TypeScript) mais flexible (comme Python).
  Ce fichier présente les bases indispensables : variables, conditions, boucles,
  et les spécificités du langage comme la *null-safety*.
*/

void main() {
  // ---------------------------------------------------------------------------
  // 🔸 VARIABLES ET TYPES
  // ---------------------------------------------------------------------------
  // En Dart :
  //   - `var` : type déduit automatiquement.
  //   - `final` : variable assignée une seule fois, à l’exécution.
  //   - `const` : constante connue à la compilation (fixée définitivement).

  var name = "Alex";        // type déduit : String
  int age = 20;             // type explicite
  final country = "France"; // non réassignable après cette ligne
  const pi = 3.14159;       // constante connue à la compilation

  // Interpolation de chaînes (comme en JS avec ${})
  print("Hello $name, age=$age, pi≈$pi");


  // ---------------------------------------------------------------------------
  // 🔸 NULL-SAFETY
  // ---------------------------------------------------------------------------
  // En Dart, par défaut, une variable ne peut PAS être `null`.
  // Si on veut qu’elle puisse l’être, il faut ajouter un `?` au type.

  String? nickname; // Peut être null (non initialisée ici)

  // L’opérateur `??` renvoie une valeur par défaut si la partie gauche est null.
  print("Surnom : ${nickname ?? "(aucun)"}");

  // L’opérateur `??=` assigne une valeur seulement si la variable est null.
  nickname ??= "Ace";
  print("Surnom après ??=: $nickname");


  // ---------------------------------------------------------------------------
  // 🔸 CONDITIONS
  // ---------------------------------------------------------------------------
  // Identique à d’autres langages, mais les parenthèses sont obligatoires.
  if (age < 18) {
    print("Mineur");
  } else if (age < 65) {
    print("Adulte");
  } else {
    print("Senior");
  }

  // Opérateur ternaire (comme en JS) : condition ? valeurSiVrai : valeurSiFaux
  final label = (age >= 18) ? "Majeur" : "Mineur";
  print("Label : $label");


  // ---------------------------------------------------------------------------
  // 🔸 BOUCLES
  // ---------------------------------------------------------------------------
  // Boucle for classique
  for (var i = 0; i < 3; i++) {
    print("for i=$i");
  }

  // Boucle while
  var n = 0;
  while (n < 3) {
    print("while n=$n");
    n++;
  }

  // Boucle for-in (comme "for x in arr" en Python)
  for (final ch in ["D", "a", "r", "t"]) {
    // `final` ici signifie que `ch` ne peut pas être réassignée
    // pendant une itération, mais change à chaque tour de boucle.
    print(ch);
  }


  // ---------------------------------------------------------------------------
  // 🧠 À RETENIR
  // ---------------------------------------------------------------------------
  // Dart est :
  //   - typé statiquement (mais avec inférence automatique)
  //   - sûr face aux valeurs nulles (null-safety)
  //   - très lisible et cohérent pour ceux qui viennent de JS ou Python


  // ---------------------------------------------------------------------------
  // 🧩 EXERCICE
  // ---------------------------------------------------------------------------
  // 1️⃣ Demander à l’utilisateur son nom et son âge
  //     → utiliser stdout.write et stdin.readLineSync()
  //
  // 2️⃣ Afficher :
  //     "Bonjour <nom>, tu auras <âge+1> ans l’année prochaine."
  //
  // 3️⃣ Si âge < 18 → "Mineur"
  //     Sinon → "Majeur"

  
}