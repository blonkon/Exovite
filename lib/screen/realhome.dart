import 'package:exovite/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Realhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {

    }
    return  WillPopScope(
        onWillPop: () async {
          // Empêche l'utilisateur de revenir en arrière à l'aide du bouton physique de retour
          return false;

        },
      child : Scaffold(
        appBar: AppBar(
          title: Text('Bienvenue'),
    ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text(
                'Soyez les bienvenus!'+user!.email.toString(),
                style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
            ),
            ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  // Ajoutez ici la logique pour rediriger vers une autre page si nécessaire
                },
                child: Text('Deconnecter'),
    ),
    ],
    ),
    ),
    ),
    );

  }
}