class Usere {
  String id;
  String nom;
  String email;
  String password;
  String classe ;
  // Constructeur
  Usere({required this.id, required this.nom, required this.email,required this.password,required this.classe});
  // Fabrique de construction à partir d'une carte (map)
  factory Usere.fromJson(Map<String, dynamic> json) {
    return Usere(
      id: json['id'],
      nom: json['nom'],
      email: json['email'],
      password: json['password'],
      classe: json['classe'],
    );
  }

}