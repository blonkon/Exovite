import 'package:exovite/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Screenone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    return
      WillPopScope(
        onWillPop: () async {
      // Empêche l'utilisateur de revenir en arrière à l'aide du bouton physique de retour
      return false;
    },
        child: Scaffold(
            body: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          "asset/onboarding/1.svg",
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.6,
                        ),
                        Text("Bienvenue sur Exovite",
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
                                  text: "Prêt à commencer votre voyage éducatif ? ",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black, // Couleur du texte
                                    fontWeight: FontWeight.normal, // Texte normal
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          "asset/onboarding/2.svg",
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.6,
                        ),
                        Text("Envoyez vos exercices",
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
                                  text: "Recevoir la correction de vos exercices quand vous voulez où vous Voulez.En un seul click !!!",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black, // Couleur du texte
                                    fontWeight: FontWeight.normal, // Texte normal
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          "asset/onboarding/3.svg",
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.6,
                        ),
                        Text("Des Sujets a GOGO",
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
                                  text: "Entrainez vous sur des sujets d'examen, de devoir, de trimestre bref soyez meilleur !!!? ",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black, // Couleur du texte
                                    fontWeight: FontWeight.normal, // Texte normal
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],),
                onboardingskip(),
                Positioned(
                    right: 24.0,
                    bottom: kBottomNavigationBarHeight,
                    child: ElevatedButton(
                      onPressed: (){
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(shape:  const CircleBorder(),backgroundColor: Color.fromRGBO(6, 102, 142, 1),),
                      child: const Icon(Icons.arrow_forward,color: Colors.white,),
                    )
                )
              ],
            )

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