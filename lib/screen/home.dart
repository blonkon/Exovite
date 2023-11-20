import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String selectedOption = '';
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

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
            SizedBox(height: 20.0),
            buildInputField('Nom Complet', Icons.person, nameController),
            SizedBox(height: 20.0),
            buildInputField('Email', Icons.email, emailController),
            SizedBox(height: 20.0),
            buildPasswordInputField('Mot de passe', Icons.lock, passwordController, obscurePassword),
            SizedBox(height: 20.0),
            buildPasswordInputField('Confirmer Mot de passe', Icons.lock, confirmPasswordController, obscureConfirmPassword),
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
                "S'inscrire",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white, // Couleur du texte
                  fontWeight: FontWeight.bold, // Texte en gras
                ),
              ),
            )

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

  Widget buildSelectBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButton<String>(
        value: selectedOption,
        items: [
          DropdownMenuItem<String>(
            value: 'Option 1',
            child: Text('Option 1'),
          ),
          DropdownMenuItem<String>(
            value: 'Option 2',
            child: Text('Option 2'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedOption = value!;
          });
        },
        hint: Text('Sélectionnez une option'),
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

  void register() {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (name.isNotEmpty && email.isNotEmpty && selectedOption.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        print('Nom Complet: $name');
        print('Email: $email');
        print('Option Sélectionnée: $selectedOption');
        print('Mot de passe: $password');
      } else {
        print('Les mots de passe ne correspondent pas.');
      }
    } else {
      print('Veuillez remplir tous les champs.');
    }
  }
}
