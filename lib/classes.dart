class Classes {
  int classeId;
  String classeName;

  Classes({this.classeId, this.classeName});

  static List<Classes> getClasses() {
    return <Classes>[
      Classes(classeId: 1, classeName: "3ème"),
      Classes(classeId: 2, classeName: "Seconde LE"),
      Classes(classeId: 3, classeName: "Seconde S"),
      Classes(classeId: 4, classeName: "Première A1"),
      Classes(classeId: 5, classeName: "Première B"),
      Classes(classeId: 6, classeName: "Première S"),
      Classes(classeId: 7, classeName: "Terminale A1"),
      Classes(classeId: 8, classeName: "Terminale B"),
      Classes(classeId: 9, classeName: "Terminale C"),
      Classes(classeId: 10, classeName: "Terminale D"),
    ];
  }
}
