import 'package:exovite/screen/home.dart';
import 'package:exovite/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Verif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return
      WillPopScope(
        onWillPop: () async {
          // Empêche l'utilisateur de revenir en arrière à l'aide du bouton physique de retour
          return false;
        },
        child: Scaffold(
            body: Column(
              children: [
                SvgPicture.asset(
                  "asset/onboarding/verif.svg",
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.6,
                ),
                Text("Verifier votre email",
                  style: TextStyle(
                    color: Color.fromRGBO(6, 102, 142, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    fontFamily: Theme.of(context).textTheme.headlineLarge!.fontFamily, // Utilisation de la police du thème
                  ),
                  textAlign: TextAlign.center,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0), // Ajoutez le padding à gauche et à droite
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "un mail de verification vous a ete envoye cliquez sur le lien ensuite connectez-vous",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black, // Couleur du texte
                            fontWeight: FontWeight.normal, // Texte normal
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Color.fromRGBO(6, 102, 142, 1)),// Ajustez le rayon de la bordure selon vos préférences
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40.0), // Ajustez la marge intérieure selon vos préférences
                    backgroundColor: Colors.white, // Couleur de fond
                  ),
                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromRGBO(6, 102, 142, 1), // Couleur du texte
                      fontWeight: FontWeight.bold, // Texte en gras
                    ),
                  ),
                ),

              ],
            ),

        ),
      );

  }

}

class onboardingskip extends StatelessWidget {
  const onboardingskip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: kToolbarHeight-20,right: 24.0,child: TextButton(onPressed: (){
      // Si le nombre de clics est supérieur à 3, redirigez vers la page d'accueil
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    },
      style: TextButton.styleFrom(
        primary: Color.fromRGBO(6, 102, 142, 1), // Couleur du texte du bouton
      ), child: const Text("Terminer"),));
  }
}