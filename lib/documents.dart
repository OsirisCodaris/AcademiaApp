class Documents {
  String titreDoc;
  String notionsDoc;
  String urlSujet;
  String urlCorrige;

  Documents({this.titreDoc, this.notionsDoc, this.urlSujet, this.urlCorrige});

  static List<Documents> getDocumets(int matiereId, int typeDoc) {
    return <Documents>[
      Documents(
          titreDoc: "Devoi 1",
          notionsDoc: "dérivée,limites.",
          urlSujet:
              "https://www.deleze.name/marcel/sec2/cours/Derivees/1/Derivee_1-Exercices_standard.pdf",
          urlCorrige:
              "http://perso.ens-lyon.fr/marion.foare/files/teaching/map101/TD/sol_TD2.pdf"),
      Documents(
          titreDoc: "Devoi 2",
          notionsDoc: "Equations,limites.",
          urlSujet:
              "https://www.deleze.name/marcel/sec2/cours/Derivees/1/Derivee_1-Exercices_standard.pdf",
          urlCorrige:
              "http://perso.ens-lyon.fr/marion.foare/files/teaching/map101/TD/sol_TD2.pdf"),
      Documents(
          titreDoc: "Devoi 3",
          notionsDoc: "Etude fonction,limites.",
          urlSujet:
              "https://www.deleze.name/marcel/sec2/cours/Derivees/1/Derivee_1-Exercices_standard.pdf",
          urlCorrige:
              "http://perso.ens-lyon.fr/marion.foare/files/teaching/map101/TD/sol_TD2.pdf"),
      Documents(
          titreDoc: "Devoi 4",
          notionsDoc: "dérivée,factorisation.",
          urlSujet:
              "https://www.deleze.name/marcel/sec2/cours/Derivees/1/Derivee_1-Exercices_standard.pdf",
          urlCorrige:
              "http://perso.ens-lyon.fr/marion.foare/files/teaching/map101/TD/sol_TD2.pdf"),
    ];
  }
}
