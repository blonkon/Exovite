
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exovite/common/Classe.dart';
import 'package:exovite/common/Usere.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  List<String> classes = <String>[' Classe'];
  Usere me = Usere(id: "", nom: "", email: "", password: "", classe: "");

  Maclasse maClasse = Maclasse('',[
  ]);
  Usere get _me => me;
  List<String> get _classes => classes ;
  Future<void> updateme() async {
    var db = FirebaseFirestore.instance;
    final docRef = await db.collection("user").doc(FirebaseAuth.instance.currentUser?.uid);
    await docRef.get().then(
          (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;
        this.me.id=doc.id;
        this.me.nom=data['nom'];
        this.me.email=data['email'];
        this.me.password=data['password'];
        final docRef2 = await db.collection("Classe").doc(data['classe']);
        await docRef2.get().then(
              (DocumentSnapshot doc) async {
                final data1 = doc.data() as Map<String, dynamic>;
                this.me.classe = data1['Nom'];
              });
      },
      onError: (e) => print("Error getting document: $e"),
    );
   // notifyListeners();
  }
  void toinitialstate(){
    this.me.email="";
    this.me.nom="";
    this.me.classe="";
    this.me.password="";
  }
  Future<List<String>> liste_classe() async {
      var db = FirebaseFirestore.instance;
      try {
        QuerySnapshot querySnapshot = await db.collection("Classe").get();
        print("Successfully completed");
        this.classes.clear();
        this.classes.add(" Classe");
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
          String nomValue = data['Nom'];
          String id = docSnapshot.id;
          print('${docSnapshot.id} => ${nomValue}');
          this.classes.add(nomValue);

        }
      } catch (e) {
        print("Error completing: $e");
      }
      //notifyListeners();
      return this.classes;
}
  Future<void> maclasses() async {
    var db = FirebaseFirestore.instance;
    final storageRef = FirebaseStorage.instance.ref();
    final docRef = await db.collection("user").doc(FirebaseAuth.instance.currentUser?.uid);
    await docRef.get().then(
          (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;

        print("ici l'id du document"+data['classe']);
        try {
          var querySnapshot = await db
              .collection("Classe")
              .doc(data['classe'])
              .collection("Matieres")
              .get();

          // Initialiser la liste en dehors de la boucle
          this.maClasse.Matieres.clear();

          for (var docSnapshot in querySnapshot.docs) {
            print('${docSnapshot.id} => ${docSnapshot.data()}');
            Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

            Matiere matiere = Matiere(data['nom'], data['recommandation'],data['img']);

            this.maClasse.Matieres.add(matiere);
          }
          // Définir le nom de la classe après avoir récupéré toutes les matières
          this.maClasse.nom = this.me.classe;
        } catch (e) {
          print("Erreur lors de la récupération des matières: $e");
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );


  }


}