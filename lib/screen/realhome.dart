import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exovite/common/Classe.dart';
import 'package:exovite/data/Data.dart';
import 'package:exovite/screen/Accueil.dart';
import 'package:exovite/screen/Download.dart';
import 'package:exovite/screen/Profile.dart';
import 'package:exovite/screen/banque.dart';
import 'package:exovite/screen/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class Realhome extends StatelessWidget {
  late PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      Accueil(),
      banques(),
      Container(),
      Download(),
      Profile()
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_filled),
        activeColorPrimary: CupertinoDynamicColor.withBrightness(
            color: Color.fromRGBO(6, 102, 142, 1), darkColor:Color.fromRGBO(6, 102, 142, 1)),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.file_copy),
        activeColorPrimary: CupertinoDynamicColor.withBrightness(
            color: Color.fromRGBO(6, 102, 142, 1), darkColor:Color.fromRGBO(6, 102, 142, 1)),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
      onPressed: (BuildContext? context) {
          showDialog(
            context: context!,
            builder: (BuildContext context) {
              return MyDialogWidget();
            },
          );
      },
    icon: Icon(CupertinoIcons.paperplane_fill,
        color: Colors.white,),
        activeColorPrimary:
    CupertinoDynamicColor.withBrightness(
    color: Color.fromRGBO(6, 102, 142, 1), darkColor:Color.fromRGBO(6, 102, 142, 1)),
    inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.upcoming),
        activeColorPrimary: CupertinoDynamicColor.withBrightness(
            color: Color.fromRGBO(6, 102, 142, 1), darkColor:Color.fromRGBO(6, 102, 142, 1)),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        activeColorPrimary: CupertinoDynamicColor.withBrightness(
            color: Color.fromRGBO(6, 102, 142, 1), darkColor:Color.fromRGBO(6, 102, 142, 1)),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ?
      PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color.fromRGBO(235, 242, 250, 1), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        boxShadow: [
      BoxShadow(
      color: Colors.black.withOpacity(0.5),
      spreadRadius: 1,
      blurRadius: 5,
      offset: Offset(0, -5),
    ),
    ],
        borderRadius: BorderRadius.circular(20.0),
        colorBehindNavBar: Color.fromRGBO(235, 242, 250, 1),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style16, // Choose the nav bar style with this property.
    ) : Login();
  }
}

class CustomTopContainer extends StatelessWidget {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mon Conteneur',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Autres widgets que vous souhaitez ajouter en dessous du conteneur
        Expanded(
          child: Container(
            color: Color.fromRGBO(235, 242, 250, 1), // Couleur de fond pour le reste de l'écran
            child: Center(
              child: Text(
                'Contenu en dessous du conteneur',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class MyDialogWidget extends StatefulWidget {
  @override
  _MyDialogWidgetState createState() => _MyDialogWidgetState();
}

class _MyDialogWidgetState extends State<MyDialogWidget> {
  String selectedValue = "";
  String filename = "";
  bool error = false;
  String errormsg = "";
  late PlatformFile file ;
  String fileurl = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset("asset/close.png", height: 32, width: 32),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset("asset/sendsu.png", width: 150, height: 150),
          error ? Text(errormsg,style: TextStyle(color: Colors.redAccent),) : Text(""),
          Text(
            'Envoyez nous votre exercice',
            style: TextStyle(
              color: Color(0xFF5A5A5A),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            child: DropdownButtonFormField<String>(
              value: selectedValue.isNotEmpty ? selectedValue : null,
              items: Provider.of<Data>(context).maClasse.Matieres.map((Matiere item) {
                return DropdownMenuItem<String>(
                  value: item.nom,
                  child: Row(
                    children: [
                      Icon(
                        Icons.subtitles_rounded,
                        color: Color.fromRGBO(6, 102, 142, 1),
                      ),
                      SizedBox(width: 8.0),
                      Text(item.nom),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                print(value);
                setState(() {
                  selectedValue = value!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Color.fromRGBO(6, 102, 142, 1)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF06668E)),
            ),
            onPressed: () async {
              try {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'jpg', 'png', 'doc'],
                );

                if (result != null) {
                  file = result.files.first;
                  setState(() {
                    filename = file.name;
                      errormsg = "";
                      error = false;
                  });
                  print('Path: ${file.path}');
                  print('Nom: ${file.name}');
                  print('Taille: ${file.size}');
                } else {
                  print('Aucun fichier sélectionné.');
                  setState(() {
                    errormsg = "veuillez selectionne un fichier";
                    error = true;
                  });
                }
              } catch (e) {
                print('Erreur lors de la sélection du fichier : $e');
                setState(() {
                  errormsg = "veuillez selectionne un fichier";
                  error = true;
                });
              }
            },
            child: Text(
              'Sélectionner un fichier',
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
          Text(filename),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              // Perform the action for the "OK" button
              print("send" + selectedValue);
              if(selectedValue.isEmpty){
                  setState(() {
                    errormsg = "Matiere manquant";
                    error = true;
                  });
              }else if(error){
                setState(() {
                  errormsg = "Fichier manquant";
                  error = true;
                });
              }else{
                print("icilepath "+file.name);
                ProgressDialog pr = ProgressDialog(context: context);
                // Close the dialog
                if (FirebaseAuth.instance.currentUser != null) {
                  print(FirebaseAuth.instance.currentUser?.uid);
                  //await FirebaseAuth.instance.signOut();
                }
                pr.show(msg: "En cours.....",barrierColor: Colors.black54,msgColor: Color.fromRGBO(6, 102, 142, 1),progressValueColor: Color.fromRGBO(6, 102, 142, 1) );
                final storageRef = FirebaseStorage.instance.ref();
                String fileName = DateTime.now().millisecondsSinceEpoch.toString();
                final mountainRef = storageRef.child("sujetenvoye");
                final filetouploadref = mountainRef.child(fileName);

                try {
                  if(file.path!.isEmpty){

                  }else{
                    await filetouploadref.putFile(File(file.path!), SettableMetadata(
                      contentType: getMimeTypeFromExtension(file.extension!),
                    ));
                    fileurl = await filetouploadref.getDownloadURL();
                  }
                } on FirebaseException catch (e) {
                  // ...
                }
                if(fileurl.isEmpty){
                  setState(() {
                    error = true;
                    errormsg = "Erreur veuillez reessayez";
                  });
                }else{
                  String correcteurid = await incrementFlux(selectedValue);
                  print("resultat du fameux fonction "+ correcteurid);
                  FirebaseFirestore.instance.collection("sujetenvoye").doc(FirebaseAuth.instance.currentUser?.uid).collection("messujet").add({
                    "nom":file.name,
                    "status":0,
                    "correction":"null",
                    "url":fileurl,
                    "correcteur":correcteurid
                  });
                }
                pr.show(msg: "Sujet envoye",barrierColor: Colors.black54,msgColor: Color.fromRGBO(6, 102, 142, 1),progressValueColor: Colors.transparent );
                pr.close(delay: 1000);
                Navigator.pop(context);
              }

            },
            child: Text('Envoyer',style: TextStyle(color: Color.fromRGBO(6, 102, 142, 1)),),
          ),
        ],
      ),
      actions: <Widget>[],
    );
  }
}


Widget buildDropdownButtonFormField(List<String> data,String lamatiere) {
  return Container(
    //padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: DropdownButtonFormField<String>(
      value: data.firstOrNull ,
      items:  data.map((String item)   {
        return DropdownMenuItem<String>(
          value: item,
          child: Row(
            children: [
              Icon(
                Icons.subtitles_rounded, // Remplacez cela par l'icône que vous souhaitez
                color: Color.fromRGBO(6, 102, 142, 1) // Couleur de l'icône
              ),
              SizedBox(width: 8.0), // Ajoutez un espace entre l'icône et le texte
              Text(item),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
          print(value);
          lamatiere = value!;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Color.fromRGBO(6, 102, 142, 1)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
      ),
    ),

  );
}


String getMimeTypeFromExtension(String extension) {
  switch (extension.toLowerCase()) {
    case 'pdf':
      return 'application/pdf';
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
      return 'image/png';
    case 'doc':
    case 'docx':
      return 'application/msword';
  // Add more cases for other file types as needed
    default:
      return 'application/octet-stream'; // Default MIME type for unknown file types
  }
}


Future<String> incrementFlux(String nomMatiere) async {
  QuerySnapshot correcteursSnapshot =
  await FirebaseFirestore.instance.collection('correcteurs').get();

  String? selectedCorrecteurUid;
  int? minFlux;

  for (QueryDocumentSnapshot correcteurDoc in correcteursSnapshot.docs) {
    int currentFlux = correcteurDoc['flux'] ?? 0;

    QuerySnapshot matieresSnapshot = await FirebaseFirestore.instance
        .collection('correcteurs')
        .doc(correcteurDoc.id)
        .collection('matieres')
        .where('nom', isEqualTo: nomMatiere)
        .get();

    if (matieresSnapshot.docs.isNotEmpty) {
      if (minFlux == null || currentFlux < minFlux) {
        minFlux = currentFlux;
        selectedCorrecteurUid = correcteurDoc.id;
      }
    }
  }

  if (selectedCorrecteurUid != null) {
    // Mettre à jour le document avec le flux le plus bas
    await FirebaseFirestore.instance
        .collection('correcteurs')
        .doc(selectedCorrecteurUid)
        .update({'flux': minFlux! + 1});
    return selectedCorrecteurUid;
  } else {
    // Aucun document trouvé avec le nom de la matière, gestion d'erreur si nécessaire
    print('Aucun document trouvé pour la matière: $nomMatiere');
    return "";
  }
}




