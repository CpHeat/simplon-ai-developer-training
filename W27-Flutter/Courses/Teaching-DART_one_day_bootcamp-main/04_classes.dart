// 04_classes.dart
// 🎯 Objectif : comprendre les bases de la programmation orientée objet (POO) en Dart.
// Concepts : classes, constructeurs, getters/setters, héritage, classes abstraites, override.
//
// Pour exécuter le code : dart run 04_classes.dart

/*
  🔹 Contexte

  Dart est un langage orienté objet : tout est objet.
  Une classe sert de *modèle* (blueprint) pour créer des objets.
  
  Chaque classe définit :
    - des *attributs* (ou propriétés)
    - des *méthodes* (ou fonctions associées)
    - éventuellement des *constructeurs* pour initialiser l’objet

  La POO permet :
    - la réutilisation du code (héritage)
    - la protection des données (encapsulation)
    - la flexibilité du comportement (polymorphisme)
*/


// ---------------------------------------------------------------------------
// 🔸 CLASSE PERSON
// ---------------------------------------------------------------------------
class Person {
  String name;  // attribut public
  int _age;     // attribut privé (le "_" le rend accessible seulement dans ce fichier)

  // Constructeur (syntaxe compacte)
  Person(this.name, this._age);

  // Getter : permet de lire la valeur de _age sans l’exposer directement
  int get age => _age;

  // Setter : permet de modifier _age avec une validation
  set age(int value) {
    if (value < 0) throw ArgumentError("L'âge doit être >= 0");
    _age = value;
  }

  // Redéfinition de toString() : facilite l’affichage de l’objet
  @override
  String toString() => "Person(name=$name, age=$_age)";
}


/*
  🧠 À retenir :
  - Le préfixe `_` rend une variable ou méthode privée au *fichier* (pas juste à la classe).
  - Les getters/setters sont des propriétés calculées, comme en Python (`@property`).
  - Le mot-clé `@override` indique qu’on redéfinit une méthode existante (ex : toString()).
*/


// ---------------------------------------------------------------------------
// 🔸 CLASSE ABSTRAITE ANIMAL
// ---------------------------------------------------------------------------
abstract class Animal {
  final String name; // final : ne peut plus être modifié après construction

  // Constructeur
  Animal(this.name);

  // Méthode abstraite : pas de corps → doit être redéfinie par les sous-classes
  void makeSound();

  // Redéfinition de toString() : $runtimeType affiche le nom réel de la classe
  @override
  String toString() => "$runtimeType(name=$name)";
}

/*
  🧠 Une classe abstraite :
  - ne peut pas être instanciée directement ;
  - sert de modèle pour ses sous-classes ;
  - peut contenir des méthodes normales ET abstraites.
*/


// ---------------------------------------------------------------------------
// 🔸 CLASSE DOG (hérite de Animal)
// ---------------------------------------------------------------------------
class Dog extends Animal {
  Dog(String name) : super(name); // appelle le constructeur parent

  // Méthode spécifique à Dog
  void bark() => print("$name : Ouaf!");

  // Redéfinition de la méthode abstraite makeSound()
  @override
  void makeSound() => bark();
}


// ---------------------------------------------------------------------------
// 🔸 CLASSE CAT (hérite de Animal)
// ---------------------------------------------------------------------------
class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void makeSound() => print("$name : Miaou!");
}


void main() {
  // Création d’un objet Person
  final p = Person("Alice", 28);
  print(p); // appelle automatiquement toString()

  // Utilisation du setter (modifie _age avec contrôle)
  p.age = 29;

  // Utilisation du getter
  print("Âge via getter : ${p.age}");

  // Création d’un chien
  final dog = Dog("Rex");
  print(dog);
  dog.bark();

  // Polymorphisme :
  // une liste d’animaux (de types différents) mais manipulés de manière uniforme
  final List<Animal> animals = [Dog("Max"), Cat("Mimi")];
  for (final a in animals) {
    a.makeSound(); // chaque sous-classe a sa propre version de makeSound()
  }

  /*
    🔹 Polymorphisme : un même appel (makeSound) produit un comportement différent
       selon le type réel de l’objet (Dog → bark / Cat → miaou)
  */

  // -------------------------------------------------------------------------
  // 🧠 À RETENIR
  // -------------------------------------------------------------------------
  // - class : définit un type d’objet
  // - _var  : variable privée au fichier
  // - get/set : contrôlent lecture/écriture d’un attribut
  // - abstract : sert de modèle (pas instanciable)
  // - extends : hérite des attributs et méthodes d’une autre classe
  // - override : redéfinit un comportement dans la sous-classe
  // - polymorphisme : un même appel produit un effet adapté au type réel

  // -------------------------------------------------------------------------
  // 🧩 EXERCICE
  // -------------------------------------------------------------------------
  // Créez une classe Animal avec un attribut `name`
  // et une méthode `cry()` qui retourne une chaîne de caractères.
  //
  // Créez une sous-classe Chien qui redéfinit `cry()` -> "Ouaf!".
  //
  // Instanciez-la et affichez son cri.


}