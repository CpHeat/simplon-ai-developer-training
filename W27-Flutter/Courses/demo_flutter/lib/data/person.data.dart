class Person {
  final String firstName;
  final String lastName;
  final String avatar;
  final String jobTitle;

  Person({
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.jobTitle,
  });
}

List<Person> people = [
    Person(firstName: "Alice", lastName: "Martin", avatar: "A", jobTitle: "Développeuse Flutter"),
    Person(firstName: "Bob", lastName: "Dylan", avatar: "B", jobTitle: "Chanteur"),
    Person(firstName: "Charlie", lastName: "Brown", avatar: "C", jobTitle: "Dessinateur"),
    Person(firstName: "Diana", lastName: "Prince", avatar: "D", jobTitle: "Superhéroïne"),
    Person(firstName: "Ethan", lastName: "Hunt", avatar: "E", jobTitle: "Agent secret"),
    Person(firstName: "Fiona", lastName: "Shrek", avatar: "F", jobTitle: "Princesse"),
    Person(firstName: "George", lastName: "Smith", avatar: "G", jobTitle: "Développeur Web"),
    Person(firstName: "Hannah", lastName: "Montana", avatar: "H", jobTitle: "Chanteuse"),
    Person(firstName: "Ivy", lastName: "League", avatar: "I", jobTitle: "Étudiante"),
    Person(firstName: "Jack", lastName: "Sparrow", avatar: "J", jobTitle: "Pirate"),
    Person(firstName: "Kara", lastName: "Zor-El", avatar: "K", jobTitle: "Superhéroïne"),
    Person(firstName: "Liam", lastName: "Neeson", avatar: "L", jobTitle: "Acteur"),
    Person(firstName: "Mia", lastName: "Wallace", avatar: "M", jobTitle: "Personnage de film"),
    Person(firstName: "Nina", lastName: "Simone", avatar: "N", jobTitle: "Chanteuse"),
    Person(firstName: "Oscar", lastName: "Wilde", avatar: "O", jobTitle: "Écrivain"),
    Person(firstName: "Paula", lastName: "Abdul", avatar: "P", jobTitle: "Chanteuse"),
    Person(firstName: "Quentin", lastName: "Tarantino", avatar: "Q", jobTitle: "Réalisateur"),
    Person(firstName: "Rachel", lastName: "Green", avatar: "R", jobTitle: "Personnage de série"),
    Person(firstName: "Steve", lastName: "Jobs", avatar: "S", jobTitle: "Entrepreneur"),
];