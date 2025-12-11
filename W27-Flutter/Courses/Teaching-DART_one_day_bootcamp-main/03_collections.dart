// 03_collections.dart
// 🎯 Objectif : manipuler les collections en Dart
// (List, Map, Set) + opérations fonctionnelles (where, map, fold, reduce, forEach)
// et syntaxes pratiques (spread, collection-if).
//
// Pour exécuter le code : dart run 03_collections.dart

/*
  🔹 Contexte

  Comme en Python (list/dict/set) ou JS (Array/Object/Set), Dart propose :
  - List<T> : tableau ordonné et indexé
  - Map<K, V> : association clé → valeur
  - Set<T> : ensemble de valeurs uniques (pas de doublons)

  Les collections Dart implémentent l’interface Iterable :
  on dispose donc d'opérateurs fonctionnels familiers : where, map, reduce, fold, any, every, etc.

  Astuces :
  - `final` fixe la *référence* de la collection, mais pas son contenu (on peut .add()).
  - `const` crée une collection *immuable* à la compilation.
*/

void main() {
  // ---------------------------------------------------------------------------
  // 🔸 LIST
  // ---------------------------------------------------------------------------
  final nums = [3, 7, 12, 4, 18, 1]; // type déduit : List<int>

  // where = filtre selon une condition (garde uniquement les éléments vrais)
  final over10 = nums.where((n) => n > 10).toList();
  print(">10: $over10"); // [12, 18]

  // map = transforme chaque élément → nouvelle liste
  final doubled = nums.map((n) => n * 2).toList();
  print("doubled: $doubled"); // [6, 14, 24, 8, 36, 2]

  // reduce vs fold :
  // - reduce combine en partant du 1er élément (attention liste vide → erreur)
  // - fold part d’un accumulateur initial (sûr même si la liste est vide)
  final sum = nums.fold<int>(0, (acc, n) => acc + n);
  final avg = sum / nums.length;
  print("sum=$sum avg=$avg");

  // Parcours : for-in (impératif) vs forEach (fonctionnel)
  for (final n in nums) {
    // boucle classique
    // print(n);
  }

  nums.forEach((n) {
    // boucle fonctionnelle (appel d'une fonction pour chaque élément)
    // print(n);
  });

  // Quelques méthodes utiles sur List :
  final sortedAsc = [...nums]..sort(); // copie + tri croissant (in-place)
  final sortedDesc = [...nums]..sort((a, b) => b.compareTo(a));
  print("sortedAsc=$sortedAsc sortedDesc=$sortedDesc");

  // Recherche :
  final hasEven = nums.any((n) => n.isEven);       // au moins un pair ?
  final allPos  = nums.every((n) => n > 0);        // tous > 0 ?
  final firstBig = nums.firstWhere((n) => n > 10); // 12 ici
  print("hasEven=$hasEven allPos=$allPos firstBig=$firstBig");


  // ---------------------------------------------------------------------------
  // 🔸 MAP (clé → valeur)
  // ---------------------------------------------------------------------------
  // `dynamic` autorise des valeurs hétérogènes (String, int, bool…)
  final Map<String, dynamic> user = {"name": "Liam", "city": "Lille"};
  user["age"] = 22; // ajout d'une nouvelle clé/valeur
  print("user keys: ${user.keys} values: ${user.values}");

  // Parcourir les paires clé/valeur
  user.forEach((k, v) => print("$k => $v"));

  // Map fortement typée :
  final scores = <String, int>{"Bob": 12, "Ana": 17};
  scores["Carl"] = 20;
  // Accès sûr :
  final ana = scores["Ana"]; // int?
  print("Ana score: $ana");


  // ---------------------------------------------------------------------------
  // 🔸 SET (valeurs uniques, non ordonnées)
  // ---------------------------------------------------------------------------
  final tags = {"dart", "flutter", "dart"}; // "dart" en double sera ignoré
  print("tags (unique): $tags"); // {dart, flutter}

  // Opérations d’ensemble :
  final a = {1, 2, 3};
  final b = {3, 4};
  print("union=${a.union(b)}");           // {1,2,3,4}
  print("inter=${a.intersection(b)}");    // {3}
  print("diff=${a.difference(b)}");       // {1,2}


  // ---------------------------------------------------------------------------
  // 🔸 OPÉRATEURS DE COLLECTION (littéraux améliorés)
  // ---------------------------------------------------------------------------
  // Spread operator (...) : insère le contenu d'une autre liste/itérable
  // Collection-if : ajoute un élément seulement si la condition est vraie
  final loggedIn = true;
  final menu = [
    "Home",
    "Docs",
    if (loggedIn) "Profile", // ajouté seulement si loggedIn est vrai
    ...["About", "Contact"], // spread d'une autre liste
  ];
  print("menu: $menu");

  // Null-aware spread : ...?listePossiblementNulle
  List<String>? extra = null;
  final full = ["A", ...?extra, "Z"]; // n'insère rien si extra est null
  print("full: $full");


  // ---------------------------------------------------------------------------
  // 🧠 À RETENIR
  // ---------------------------------------------------------------------------
  // - List : ordonnée, indexée → where/map/fold/reduce/any/every/firstWhere…
  // - Map  : clé→valeur, forEach(k,v), keys/values
  // - Set  : unique, union/intersection/difference
  // - Spread (...) et collection-if pour construire des listes dynamiques
  // - `final` ≠ immuable : fixe la *référence* seulement. Utiliser `const` pour immuable.


  // ---------------------------------------------------------------------------
  // 🧩 EXERCICES
  // ---------------------------------------------------------------------------
  // 1) À partir d'une liste d'entiers, produire :
  //    - une liste des nombres pairs
  //    - la valeur maximale
  //    - une nouvelle liste avec chaque nombre au carré (n*n)
  //
  // 2) Construire une Map<String, int> comptant le nombre d’occurrences
  //    de chaque mot dans : "hello hello dart is fun fun"
  //
  // 💡 Indices :
  //    - pairs : where((n) => n.isEven)
  //    - max : reduce(max) ou fold avec un initial
  //    - carré : map((n) => n * n)
  //    - comptage : split(" ") puis fold sur une Map

  
}