class Maclasse{
  String nom;
  List<Matiere> Matieres ;
  Maclasse(this.nom, this.Matieres);
}

class Matiere {
  final String nom;
  final String recommandation;
  final String img;
  Matiere(this.nom, this.recommandation, this.img);
}

class Sujet {
  final String nom;
  final String correction;
  final int status;
  Sujet(this.nom, this.correction, this.status);
}
