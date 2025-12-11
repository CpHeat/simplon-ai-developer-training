// 02_functions.dart
// 🎯 Objectif : comprendre les fonctions en Dart
// (paramètres positionnels/nommés, optionnels, valeurs par défaut, fléchées, null-safety)
//
// Pour exécuter le code : dart run 02_functions.dart

import 'dart:math';

/*
  🔹 Contexte

  En Dart, les fonctions sont très flexibles :
  - Paramètres positionnels (obligatoires ou optionnels)
  - Paramètres nommés (facultatifs par défaut, plus lisibles à l’appel)
  - Valeurs par défaut
  - Null-safety : types nullable (T?) et opérateurs ?? et ?.
  - Syntaxe fléchée => pour des fonctions à une seule expression (comme JS "arrow")
*/


// ---------------------------------------------------------------------------
// 🔸 FONCTION CLASSIQUE (paramètres positionnels OBLIGATOIRES)
// ---------------------------------------------------------------------------
int add(int a, int b) {
  return a + b;
}

// 🔸 FONCTION FLÉCHÉE (une seule expression)
int addArrow(int a, int b) => a + b;


// ---------------------------------------------------------------------------
// 🔸 PARAMÈTRE POSITIONNEL OPTIONNEL (avec valeur par défaut)
//    - Entre crochets [] : argument optionnel à l’appel
//    - Ici, name vaut "world" si non fourni
// ---------------------------------------------------------------------------
void greet([String name = "world"]) {
  print("Hello, $name!");
}


// ---------------------------------------------------------------------------
// 🔸 PARAMÈTRES NOMMÉS (entre {}) + null-safety
//    - On peut omettre name et age à l’appel
//    - On gère les nulls avec ?? et un test explicite
// ---------------------------------------------------------------------------
String describePerson({String? name, int? age}) {
  final n = name ?? "inconnu";                 // si name est null → "inconnu"
  final a = (age != null) ? "$age" : "inconnu"; // si age est null → "inconnu"
  return "Personne: nom=$n, age=$a";
}

/*
  ℹ️ À savoir :
  - On peut rendre un paramètre nommé *obligatoire* avec `required` :
      String profile({required String id, String? tag})
  - On peut combiner `required` et `nullable` si utile : `required String? x`
*/


// ---------------------------------------------------------------------------
// 🔸 OPÉRATEURS "NULL-AWARE"
//    s?.length  → si s est null, renvoie null (au lieu de lancer une erreur)
//    ??  → valeur par défaut si la partie gauche est null
// ---------------------------------------------------------------------------
int lenOrZero(String? s) => s?.length ?? 0; // si s est null → 0, sinon sa longueur


void main() {
  // Démonstrations
  print(add(2, 3));              // 5
  print(addArrow(5, 7));         // 12

  greet();                       // Hello, world!
  greet("John");                 // Hello, John!

  print(describePerson(name: "Mina", age: 30)); // nom et âge donnés
  print(describePerson(age: null, name: null)); // aucun renseignement
  print(describePerson());                      // les deux omis

  // Variable potentiellement nulle
  String? maybe = null;
  print(lenOrZero(maybe));       // 0 car null
  maybe = "dart";
  print(lenOrZero(maybe));       // 4 (longueur de "dart")

  // -------------------------------------------------------------------------
  // 🧠 À RETENIR
  // - [] → paramètres positionnels optionnels
  // - {} → paramètres nommés (lisibles, peuvent être omis, -> utiliser `required` si besoin)
  // - Valeurs par défaut pour éviter les checks partout
  // - Null-safety : T? + ?. + ??
  // - => pour les fonctions à expression unique
  // -------------------------------------------------------------------------

  // 🧩 Exercice :
  // Crée une fonction `describePerson2({String? name, int? age})`
  // qui retourne une chaîne selon ces cas :
  // - nom et âge présents :  "<name> a <age> ans."
  // - seulement nom :        "<name>, âge inconnu."
  // - seulement âge :        "Âge: <age>, nom inconnu."
  // - ni nom ni âge :        "Personne inconnue."
  
}