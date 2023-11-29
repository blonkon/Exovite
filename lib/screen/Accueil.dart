import 'dart:math';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exovite/common/Classe.dart';
import 'package:exovite/data/Data.dart';
import 'package:exovite/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
                        verticalDirection: VerticalDirection.down,
                        children: [
                          SizedBox(height: 20,),
                          Text(
                            'Ravi de vous revoir',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 20,),
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
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Text("  Recommandations",
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontFamily: 'Poppins',
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              height: 1.2, // La hauteur de ligne (line-height en CSS)
            ),
          ),
            SizedBox(height: 10.0),
            Consumer<Data>(
              builder: (context, data, child) {
                return FutureBuilder(future: data.maclasses(), builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Color(0xFF06668E),
                          width: 1.0,
                        ),
                        color: Color(0xFF06668E),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 7),
                            blurRadius: 15.0,
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20,),
                                    CustomTextWidget(text: "Matieres"),
                                    SizedBox(height: 10,),
                                    CustomTextWidget2(text: "Cet Sujet est fortement recommandée par nos enseignants "),
                                    SizedBox(height: 20,),
                                    GestureDetector(
                                      onTap: () {
                                        // Action à effectuer lorsqu'on appuie sur le conteneur
                                      },
                                      child: Container(
                                        padding: EdgeInsetsDirectional.symmetric(horizontal: 5),
                                        height: 22.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          // Votre contenu à l'intérieur du conteneur, par exemple, du texte
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Telecharger',
                                                  style: TextStyle(
                                                      color: Color(0xFF06668E),
                                                      fontSize: 10,
                                                      decoration: TextDecoration.none
                                                  ),
                                                ),
                                                Icon(Icons.download_outlined,color: Color(0xFF06668E),)
                                              ],
                                            )
                                        ),
                                      ),
                                    )
                                  ]
                              ),
                              Image.asset("asset/book.png", width: 100, height: 100),
                            ],
                          ),

                        ],
                      ),
                    );
                  }
                  return
                    CarouselSlider(
                  options: CarouselOptions(height: MediaQuery.of(context).size.height*0.2),
                  items: data.maClasse.Matieres.map((item) {
                    return CustomCarouselItem(title: item.nom, imagePath: item.img,);
                }).toList(),
                );
              } );
            }),
            SizedBox(height: 10.0),
            Text("  Matieres",
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
                fontSize: 20.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                height: 1.2, // La hauteur de ligne (line-height en CSS)
              ),
            ),
            //matiere
            Consumer<Data>(
                builder: (context, data, child) {
                  return FutureBuilder(future: data.maclasses(), builder: (context, snapshot) {
                    List<Matiere> mesmatiere = List.of(data.maClasse.Matieres);
                    Matiere toutMatiere = Matiere('Tout', 'Le tout ', 'asset/book.png');
                    mesmatiere.insert(0, toutMatiere);
                    if(snapshot.connectionState==ConnectionState.waiting){
                      CircularProgressIndicator();
                    }
                    return
                      Listhori(matieres: mesmatiere,);
                  } );
                }),
            Text("  Sujet envoyes",
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
                fontSize: 20.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                height: 1.2, // La hauteur de ligne (line-height en CSS)
              ),
            ),
            SingleChildScrollView(
              child: UserInformation(),
            )


        ],
        )
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

class CustomTextWidget extends StatelessWidget {
  final String text;

  CustomTextWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontFamily: 'Poppins',
        fontSize: 20.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        // line-height n'est pas directement pris en charge dans TextStyle
        // Vous pouvez ajuster la hauteur de ligne en modifiant la hauteur de la boîte du conteneur qui contient ce widget.
      ),
    );
  }
}

class CustomTextWidget2 extends StatelessWidget {
  final String text;

  CustomTextWidget2({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 150.0), // Ajustez la largeur maximale selon vos besoins
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFFEBF2FA),
          fontFamily: 'Poppins',
          decoration: TextDecoration.none,
          fontSize: 10.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          // line-height n'est pas directement pris en charge dans TextStyle
          // Vous pouvez ajuster la hauteur de ligne en modifiant la hauteur de la boîte du conteneur qui contient ce widget.
        ),
      ),
    );
  }
}

class CustomCarouselItem extends StatelessWidget {
  final String title;
  final String imagePath;

  CustomCarouselItem({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Color(0xFF06668E),
              width: 1.0,
            ),
            color: Color(0xFF06668E),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 7),
                blurRadius: 15.0,
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(height: 20,),
                       CustomTextWidget(text: title),
                       SizedBox(height: 10,),
                       CustomTextWidget2(text: "Cet Sujet est fortement recommandée par nos enseignants "),
                       SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () {
                // Action à effectuer lorsqu'on appuie sur le conteneur
                             },
                          child: Container(
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 5),
                            height: 22.0,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                             ),
                             child: Center(
                               // Votre contenu à l'intérieur du conteneur, par exemple, du texte
                                child: Row(
                                  children: [
                                    Text(
                                      'Telecharger',
                                      style: TextStyle(
                                        color: Color(0xFF06668E),
                                        fontSize: 10,
                                        decoration: TextDecoration.none
                                      ),
                                    ),
                                    Icon(Icons.download_outlined,color: Color(0xFF06668E),)
                                  ],
                                )
                              ),
                              ),
                            )
                     ]
                   ),
                  Image.network(imagePath, width: 100, height: 100),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
}

//pour le button telecharger
class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Action à effectuer lorsqu'on appuie sur le conteneur
      },
      child: Container(
        width: 106.7,
        height: 22.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Center(
          // Votre contenu à l'intérieur du conteneur, par exemple, du texte
          child: Text(
            'Telecharger',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}

class Listhori extends StatelessWidget {
  final List<int> warmColors = [
    0xFFEF5350,
    0xFFEC407A,
    0xFFAB47BC,
    0xFF7E57C2,
    0xFF5C6BC0,
    0xFF42A5F5,
    0xFF29B6F6,
    0xFF26C6DA,
    0xFF26A69A,
    0xFF66BB6A,
    0xFF9CCC65,
    0xFFFFEE58,
    0xFFFFCA28,
    0xFFFFA726,
    0xFF8D6E63,
    0xFF78909C,
    0xFF90A4AE,
    0xFFCFD8DC,
    0xFF455A64,
    0xFFD32F2F,
    0xFFE57373,
    0xFFF06292,
    0xFFBA68C8,
    0xFF9575CD,
    0xFF7986CB,
    0xFF64B5F6,
    0xFF4FC3F7,
    0xFF4DD0E1,
    0xFF4DB6AC,
    0xFF81C784,
    0xFFAED581,
    0xFFFFD54F,
    0xFFFFB74D,
    0xFFFF8A65,
    0xFFA1887F,
    0xFF90A4AE,
    0xFFB0BEC5,
    0xFFCFD8DC,
    0xFF607D8B,
  ];
  List<Matiere> matieres;
  Color getRandomColor() {
    Random random = Random();
    return Color(warmColors[random.nextInt(warmColors.length)]);
  }
  Listhori({required this.matieres});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:  matieres.length,
        itemBuilder: (BuildContext context, int index) {
          Matiere matiere = matieres[index];
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6.0),
                height: 64.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: getRandomColor(),
                ),
                child: matiere.img.startsWith('asset/') // Vérifiez si l'image provient d'asset
                    ? Image.asset(matiere.img,) // Chargez l'image d'asset
                    : Image.network(matiere.img, width: 62, height: 62),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 5),
                child: Text(
              matiere.nom,
              style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          decoration: TextDecoration.none,
          fontSize: 12.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          ),
          ),
              ),

            ],
          );
        },
      ),
    );
  }
}


class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('sujetenvoye').doc(FirebaseAuth.instance.currentUser?.uid).collection("messujet").where("status", isNotEqualTo: -1).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Un probleme');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return snapshot.data!.docs.isEmpty ? Center(
          child: Image.asset("asset/empt.png",width: 200,height: 200,),
        ) : Material(
          child: Container(
            color: Color.fromRGBO(235, 242, 250, 1),
            height: 200,
            // Set a fixed height or use other constraints
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
                var data1 = snapshot.data!.docs[index];
                return  Container(
                    margin: EdgeInsetsDirectional.only(start: 10,end: 10,bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white, // Couleur de fond du Container
                      border: Border.all(color: Color(0xFF06668E)), // Couleur de la bordure
                      borderRadius: BorderRadius.circular(10.0), // Ajustez le rayon de la bordure selon vos besoins
                    ),
                child: data['status'] == 0
                ? ListTile(
                leading: Icon(Icons.file_open, color: Color(0xFF06668E)),
                title: Text(data['nom']),
                trailing: IconButton( onPressed: (
                    ) async {
                  bool? deleteConfirmed = await _showDeleteConfirmationDialog(context);
                  // Supprimer l'élément seulement si l'utilisateur a confirmé
                  if(deleteConfirmed==null){

                  }else{
                    if (deleteConfirmed) {
                      print("l'id du sujet " + data1.id);
                      var db = FirebaseFirestore.instance;
                      db.collection("sujetenvoye").doc(FirebaseAuth.instance.currentUser?.uid).collection("messujet").doc(data1.id).delete().then(
                            (doc) => () async {
                              final storageRef = FirebaseStorage.instance.ref();
                              final desertRef = storageRef.child("sujetenvoye/"+data1.id+"."+data['extension']);
                              await desertRef.delete();
                              print("Document deleted");
                              },

                        onError: (e) => print("Error updating document $e"),
                      );


                    }
                  }

                  }, icon: Icon(
                  Icons.close, // Choisissez une icône appropriée
                  color: Colors.redAccent,
                ) ,),
                )
                    : data['status'] == 1
                ? ListTile(
                leading: Icon(Icons.file_open, color: Color(0xFF06668E)),
                title: Text(data['nom']),
                trailing: Icon(Icons.circle_outlined, color: Color(0xFF06668E)),
                )
                    :
                ListTile(
                leading: Icon(Icons.file_open, color: Color(0xFF06668E)),
                title: Text(data['nom']),
                trailing: Icon(Icons.download, color: Color(0xFF06668E)),
                ));
              },
            ),
          ),
        ) ;
      },
    );
  }
}



Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        content: Text("Voulez-vous vraiment annuler la correction ?"),
        actions: [

          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Confirmer la suppression
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Text("Oui",style: TextStyle(color: Colors.red),),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Confirmer la suppression
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF06668E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Text("Non",style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },
  );
}

