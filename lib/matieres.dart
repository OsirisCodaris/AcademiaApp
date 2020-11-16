class Matieres{
  int matiereId;
  String matiereName;
  int nbDocument=0;
  int nbDocumentConsulte=0;

  Matieres({this.matiereId,this.matiereName,this.nbDocument,this.nbDocumentConsulte});

  static List<Matieres> getAllMatieres(){
    return<Matieres>[
      Matieres(matiereId: 1, matiereName: "Mathématique"),
      Matieres(matiereId: 2, matiereName: "Sciences physiques"),
      Matieres(matiereId: 3, matiereName: "Sciences de la Vie et de la Terre"),
      Matieres(matiereId: 4, matiereName: "Français"),
      Matieres(matiereId: 5, matiereName: "Philosophie"),
      Matieres(matiereId: 6, matiereName: "Science Economique et Sociales"),
      Matieres(matiereId: 7, matiereName: "Histoire Géographie"),
      Matieres(matiereId: 8, matiereName: "Anglais"),
      Matieres(matiereId: 9, matiereName: "Espagnol"),
    ];
  }

  static List<Matieres> getMatieresClasse(){
    return<Matieres>[
      Matieres(matiereId: 1, matiereName: "Mathématique",nbDocument: 40,nbDocumentConsulte: 20),
      Matieres(matiereId: 2, matiereName: "Sciences physiques",nbDocument: 100,nbDocumentConsulte: 60),
      Matieres(matiereId: 3, matiereName: "Sciences de la Vie et de la Terre",nbDocument: 130,nbDocumentConsulte: 50),
      Matieres(matiereId: 4, matiereName: "Français",nbDocument: 80,nbDocumentConsulte: 30),
    ];
  }
}