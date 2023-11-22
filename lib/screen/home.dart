import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exovite/screen/login.dart';
import 'package:exovite/screen/realhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  late FirebaseFirestore db; // Declare the type explicitly

  @override
  void initState() {
    super.initState();
    initializeFirestore();
  }
  List<String> _liste = <String>[' Classe',];
  Future<void> initializeFirestore() async {
    db = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await db.collection("Classe").get();
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        String nomValue = data['Nom'];

        print('${docSnapshot.id} => ${nomValue}');
        _liste.add(nomValue);

      }
    } catch (e) {
      print("Error completing: $e");
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            buildDropdownButtonFormField(),
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
    );
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


  Widget buildDropdownButtonFormField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonFormField<String>(
        value: _liste.first,
        items: _liste.map((String item) {
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
            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
            final data = <String, dynamic>{
              "nom": name,
              "email": email,
              "classe": selectedOption
            };

            db.collection("user").doc(credential.user?.uid).set(data, SetOptions(merge: true));
            Navigator.push(context, MaterialPageRoute(builder: (context) => Realhome()));
          } on FirebaseAuthException catch (e) {
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
