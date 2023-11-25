import 'package:exovite/data/Data.dart';
import 'package:exovite/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class Accueil extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150.0, // Hauteur fixe du conteneur en haut
          decoration: BoxDecoration(
            color: Color.fromRGBO(6, 102, 142, 1), // Couleur du conteneur
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0), // Bordure en bas à gauche
              bottomRight: Radius.circular(20.0), // Bordure en bas à droite
            ),
          ),
          child: Consumer<Data>(
            builder: (context, data, child) {
             return FutureBuilder(
                future: data.updateme(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    //CircularProgressIndicator();
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator()
                      ],
                    );
                  }
                  if(snapshot.hasError){

                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromRGBO(235, 242, 250, 1),
                        child: Text(firstletter(data.me.nom),style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Color.fromRGBO(6, 102, 142, 1),
                        ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ravi de vous revoir',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),

                          Text(
                            firstword(data.me.nom),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,

                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child : Icon(Icons.notifications,size: 60,color: Color.fromRGBO(235, 242, 250, 1),),
                        onTap: (){
                          print("Notification page");
                        },
                      )
                    ],
                  );
                },
              );
        }),
        ),
        // Autres widgets que vous souhaitez ajouter en dessous du conteneur
        Expanded(
          child: Container(
            color: Color.fromRGBO(235, 242, 250, 1), // Couleur de fond pour le reste de l'écran
            child: Center(
              child: TextButton(

                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  pushNewScreen<dynamic>(
                    context,
                    screen: Login(),
                    withNavBar: false,
                  );
                }
              , child: Text('Deconnecter'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
String firstletter(String mot) {
  // Assurez-vous que le mot n'est pas vide
  if (mot.isNotEmpty) {
    // Parcourez chaque caractère du mot
    for (int i = 0; i < mot.length; i++) {
      // Convertissez le caractère en majuscule
      String caractere = mot[i].toUpperCase();

      // Vérifiez si le caractère est une lettre de l'alphabet
      if (RegExp('[A-Z]').hasMatch(caractere)) {
        return caractere;
      }
    }
  }

  // Retournez une valeur par défaut si le mot est vide ou si aucune lettre de l'alphabet n'a été trouvée
  return '';
}
String firstword(String phrase) {
  if (phrase.isNotEmpty) {
    // Séparez la phrase en mots
    List<String> mots = phrase.split(' ');

    // Parcourez les mots jusqu'à trouver un mot de moins de 16 caractères
    for (String mot in mots) {
      if (mot.length < 16) {
        return mot;
      }
    }

    // Si aucun mot n'est trouvé, retournez les 13 premiers caractères du premier mot avec trois points de suspension
    if (mots.isNotEmpty) {
      return mots[0].substring(0, 13) + '...';
    }
  }

  // Retournez une valeur par défaut si la phrase est vide
  return '';
}