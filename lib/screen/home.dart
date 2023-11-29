import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exovite/data/Data.dart';
import 'package:exovite/screen/emailverificationpage.dart';
import 'package:exovite/screen/login.dart';
import 'package:exovite/screen/realhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/options/completed.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  late FirebaseFirestore db; // Declare the type explicitly

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String selectedOption = '';
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool echec = false;
  String echecmsg='';
  List<String> classe = <String>["Test"];

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null ?
    Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Image.asset("asset/logo.png"),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Inscription", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0,color: Color.fromRGBO(6, 102, 142, 1),)),
            ),
            SizedBox(height: 10.0),
            echec == true ? Text(echecmsg,style: TextStyle(color: Colors.redAccent),) : Container() ,
            SizedBox(height: 10.0),
            buildInputField('Nom Complet', Icons.person, nameController),
            SizedBox(height: 20.0),
            buildInputField('Email', Icons.email, emailController),
            SizedBox(height: 20.0),
            Consumer<Data>(
              builder: (context, data, child) {
              return FutureBuilder(
                  future: data.liste_classe(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                     return buildDropdownButtonFormField(data.classes);
                    }
                    if(snapshot.hasError){

                    }
                    return buildDropdownButtonFormField(snapshot.data!);
                  },
              );
            }),
            SizedBox(height: 20.0),
            buildPasswordInputField('Mot de passe', Icons.lock, passwordController, obscurePassword),
            SizedBox(height: 20.0),
            buildPasswordInputField('Confirmer Mot de passe', Icons.lock, confirmPasswordController, obscureConfirmPassword),
            SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  register();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Ajustez le rayon de la bordure selon vos préférences
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40.0), // Ajustez la marge intérieure selon vos préférences
                  backgroundColor: Color.fromRGBO(6, 102, 142, 1), // Couleur de fond
                ),
                child: Text(
                  " S'inscrire ",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white, // Couleur du texte
                    fontWeight: FontWeight.bold, // Texte en gras
                  ),
                ),
              ),


            SizedBox(height: 10.0),
            Text("OU",
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromRGBO(6, 102, 142, 1), // Couleur du texte
                  fontWeight: FontWeight.bold, // Texte en gras
                )),
            SizedBox(height: 10.0),
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
    ): Realhome();
  }

  Widget buildInputField(String label, IconData icon, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon,color: Color.fromRGBO(6, 102, 142, 1),),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide( color : Color.fromRGBO(6, 102, 142, 1),),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
        ),
      ),
    );
  }


  Widget buildDropdownButtonFormField(List<String> data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonFormField<String>(
        value: data.firstOrNull ,
        items:  data.map((String item)   {
          return DropdownMenuItem<String>(
            value: item,
            child: Row(
              children: [
                Icon(
                  Icons.maps_home_work_outlined, // Remplacez cela par l'icône que vous souhaitez
                  color: Color.fromRGBO(6, 102, 142, 1), // Couleur de l'icône
                ),
                SizedBox(width: 8.0), // Ajoutez un espace entre l'icône et le texte
                Text(item),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
        decoration: InputDecoration(
          labelText: 'Sélectionnez une option',
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

  Widget buildPasswordInputField(String label, IconData icon, TextEditingController controller, bool obscureText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon,color: Color.fromRGBO(6, 102, 142, 1),),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                if (label == 'Mot de passe') {
                  obscurePassword = !obscurePassword;
                } else {
                  obscureConfirmPassword = !obscureConfirmPassword;
                }
              });
            },
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Color.fromRGBO(6, 102, 142, 1),),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
        ),
      ),
    );
  }

  Future<void> register() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    ProgressDialog pr = ProgressDialog(context: context);

    // Expression régulière pour la validation de l'email
    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        selectedOption.isNotEmpty && selectedOption!=" Classe"&&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (emailRegExp.hasMatch(email)) {
        if (password == confirmPassword) {
          print('Nom Complet: $name');
          print('Email: $email');
          print('Option Sélectionnée: $selectedOption');
          print('Mot de passe: $password');
          try {
            pr.show(msg: "En cours.....",barrierColor: Colors.black54,msgColor: Color.fromRGBO(6, 102, 142, 1),progressValueColor: Color.fromRGBO(6, 102, 142, 1) );
            QuerySnapshot querySnapshot = await db.collection("Classe").where("Nom", isEqualTo: selectedOption).get();

            for (var docSnapshot in querySnapshot.docs) {
              Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
              selectedOption = docSnapshot.id;
            }
            final data = <String, dynamic>{
              "nom": name,
              "email": email,
              "classe": selectedOption,
              "password" : password,
            };
            final data1 = <String,dynamic>{
              "nom":"",
              "correction":"",
              "status":-1
            };
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            ).then((value) async => {
            await FirebaseAuth.instance.setLanguageCode("fr"),
              await value.user?.sendEmailVerification(),
            db.collection("user").doc(value.user?.uid).set(data, SetOptions(merge: true)),
              db.collection("sujetenvoye").doc(value.user?.uid).collection("messujet").add(data1)
            });
            await FirebaseAuth.instance.signOut();
            setState(() {
              echec = false;
              echecmsg="";
              nameController.text = "";
              emailController.text = "";
              passwordController.text = "";
              confirmPasswordController.text = "";
            });
            pr.close();
            Provider.of<Data>(context,listen: false).toinitialstate();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Verif()),
            );
          } on FirebaseAuthException catch (e) {
            pr.close();
            if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
              setState(() {
                echec = true;
                echecmsg="Email existant";
              });
            } else if (e.code == 'weak-password') {
              print('The password provided is too weak.');
              setState(() {
                echec = true;
                echecmsg="Mot de passe faible ";
              });
            }
          } catch (e) {
            pr.close();
            setState(() {
              echec = true;
              echecmsg="Donnee invalid";
            });
            print(e);
          }
        } else {
          setState(() {
            echec = true ;
            echecmsg="Mot de passe different";
          });
        }
      } else {
        setState(() {
          echec = true ;
          echecmsg="Email Invalid";
        });
      }
    } else {

      setState(() {
        echec =true ;
        echecmsg="Donnee Invalid";
      });
    }
  }


}
