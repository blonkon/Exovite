import 'package:exovite/data/Data.dart';
import 'package:exovite/screen/home.dart';
import 'package:exovite/screen/onboarding/screenone.dart';
import 'package:exovite/screen/realhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/options/completed.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class Login extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              padding: EdgeInsets.only(top: 60),
              child: Image.asset("asset/logo.png"),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Connexion", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0,color: Color.fromRGBO(6, 102, 142, 1),)),
            ),
            SizedBox(height: 20.0),
            echec == true ? Text(echecmsg,style: TextStyle(color: Colors.redAccent),) : Container() ,
            //buildInputField('Nom Complet', Icons.person, nameController),
            SizedBox(height: 40.0),
            buildInputField('Email', Icons.email, emailController),
            SizedBox(height: 20.0),
            buildPasswordInputField('Mot de passe', Icons.lock, passwordController, obscurePassword),
            //SizedBox(height: 20.0),
            //buildPasswordInputField('Confirmer Mot de passe', Icons.lock, confirmPasswordController, obscureConfirmPassword),
            SizedBox(height: 30.0),
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
                " Se connecter ",
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
                //register();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
                "S'inscrire",
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
    String email = emailController.text;
    String password = passwordController.text;
    ProgressDialog pr = ProgressDialog(context: context);
    // Expression régulière pour la validation de l'email
    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );

    if (
        email.isNotEmpty &&
        password.isNotEmpty ) {
      if (emailRegExp.hasMatch(email)) {
          print('Email: $email');
          print('Mot de passe: $password');
          try {
            if (FirebaseAuth.instance.currentUser != null) {
              print(FirebaseAuth.instance.currentUser?.uid);
              //await FirebaseAuth.instance.signOut();
            }
            pr.show(msg: "En cours.....",barrierColor: Colors.black54,msgColor: Color.fromRGBO(6, 102, 142, 1),progressValueColor: Color.fromRGBO(6, 102, 142, 1) );
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password
            ).then((value) async => {
            if(value.user!.emailVerified){
                setState(() {
                Provider.of<Data>(context,listen: false).toinitialstate();
                echec = false;
                echecmsg="";
                emailController.text = "";
                passwordController.text = "";
                Provider.of<Data>(context,listen: false).updateme().then((value) => (){
                  Provider.of<Data>(context,listen: false).maclasses().then((value) => (){
                    pr.close();
                  });
                });
              }),
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Realhome()))
                }
            else{
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
            ),
            await FirebaseAuth.instance.signOut(),
              setState(() {
                Provider.of<Data>(context,listen: false).toinitialstate();
                echec = true;
                echecmsg="Email non verifier";
                emailController.text = "";
                passwordController.text = "";
                pr.close();
              }),
            },

            });

            //credential.user.uid ;
          } on FirebaseAuthException catch (e) {

            if (e.code == 'user-not-found') {
              print('No user found for that email.');
              setState(() {
                echec = true;
                echecmsg="Email ou mot de passe invalid";
              });
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
              setState(() {
                echec = true;
                echecmsg="Email ou mot de passe invalid";
              });
            }
            setState(() {
              echec = true;
              echecmsg="Email ou mot de passe invalid";
            });
            pr.close();
          }
      } else {
        setState(() {
          echec = true;
          echecmsg="Email ou mot de passe invalid";
        });
        print('Veuillez saisir une adresse e-mail valide.');
      }
    }else{
      setState(() {
        echec = true;
        echecmsg="Donnee invalid";
      });
    }
  }

}