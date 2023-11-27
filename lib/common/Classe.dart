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
