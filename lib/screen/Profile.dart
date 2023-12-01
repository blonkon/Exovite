import 'package:exovite/data/Data.dart';
import 'package:exovite/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
    child:  Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/2+30,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 267,
                decoration: BoxDecoration(
                  color: Color(0xFF06668E),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text('Mon Profil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width*0.1,
                top: 160,
                child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 240,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBF2FA),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(6, 6),
                          spreadRadius: 0,
                        ),],),
                    child: Consumer<Data>(builder : (context,data,child) {
                      return Column(
                        children: [
                          Icon(Icons.person,color: Color(0xFF06668E),size: 100 ,),
                          Text(data.me.nom,style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),),
                          SizedBox(height: 10),
                          Text(data.me.classe,style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),),
                          SizedBox(height: 10),
                          Text(data.me.email,style: TextStyle(
                            color: Color(0x3F000000),
                            decoration: TextDecoration.none,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),),
                          SizedBox(height: 10),
                          Text("Compte gratuit",style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),),
                        ],
                      );
                    })
                ),
              ),
            ],
          ),
        ),
        Material(
          child: SingleChildScrollView(
           child: Column(
             children: [
               ListTile(
                 leading: Icon (Icons.edit),
                 title: Text("Modifier mes coordonnees",style: TextStyle(fontSize: 18),),
               ),
               ListTile(
                 leading: Icon (Icons.refresh),
                 title: Text("Reinitialise toute mes donnees ",style: TextStyle(fontSize: 18),),
               ),
               ListTile(
                 leading: Icon (Icons.delete,color: Colors.red,),
                 title: Text("Supprimer toutes mes donnees",style: TextStyle(fontSize: 18,color: Colors.red),),
               ),
               ListTile(
                 leading: Icon (Icons.delete,color: Colors.red,),
                 title: Text("Supprimer mon compte ",style: TextStyle(fontSize: 18,color: Colors.red),),
               ),
               ListTile(
                 onTap: (){
                   FirebaseAuth.instance.signOut();
                   pushNewScreen<dynamic>(
                     context,
                     screen: Login(),
                     withNavBar: false,
                   );
                 },
                 leading: Icon (Icons.logout,color: Color(0xFF06668E),),
                 title: Text("Se Deconnecter",style: TextStyle(fontSize: 18,color: Color(0xFF06668E)),),
               ),

             ],
           ),
          ),
        )

      ],
    )
    );
  }
}



