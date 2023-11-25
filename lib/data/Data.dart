
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exovite/common/Usere.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  List<String> classes = <String>[' Classe'];
  Usere me = Usere(id: "", nom: "", email: "", password: "", classe: "");
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
        var docRef2 = await db.collection("Classe").doc(data['classe']);
        docRef2.get().then(
              (DocumentSnapshot doc) {
                final data2 = doc.data() as Map<String, dynamic>;
                this.me.classe = data2['Nom'];
              });
        print(data);
        print(this.me.classe);
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

}