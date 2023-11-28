import 'package:exovite/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 430,
      height: 932,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 430,
              height: 267,
              decoration: ShapeDecoration(
                color: Color(0xFF06668E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 836,
            child: Container(
              width: 430,
              height: 96,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 21,
                    child: Container(
                      width: 430,
                      height: 75,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 9,
                            offset: Offset(0, -5),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 184,
                    top: 0,
                    child: Container(
                      width: 64,
                      height: 64,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: ShapeDecoration(
                                color: Color(0xFF06668E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 20),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 57,
            top: 134,
            child: Container(
              width: 316,
              height: 258,
              decoration: ShapeDecoration(
                color: Color(0xFFEBF2FA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(6, 6),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 165,
            top: 53,
            child: Text(
              'Mon profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 130,
            top: 237,
            child: Text(
              'Ibrahim B Diakite',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 104,
            top: 282,
            child: Text(
              'Terminale Sciences Exactes',
              style: TextStyle(
                color: Color(0xFF5A5A5A),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 57,
            top: 321,
            child: SizedBox(
              width: 316,
              child: Text(
                'Diakiteibrahimblonkon@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5A5A5A),
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 108,
            top: 740,
            child: Container(
              width: 214,
              height: 45,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 214,
                      height: 45,
                      decoration: ShapeDecoration(
                        color: Color(0xFF06668E),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF06668E)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 9,
                    child: SizedBox(
                      width: 214,
                      child: Text(
                        'Abonnement',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 32,
            top: 667,
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 0,
                  child: Text(
                    'Se Deconnecter',
                    style: TextStyle(
                      color: Color(0xFF427AA1),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 32,
            top: 605,
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 0,
                  child: Text(
                    'Supprimer mon compte',
                    style: TextStyle(
                      color: Color(0xFFAD0000),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 29,
            top: 543,
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 0,
                  child: Text(
                    'Supprimer  toutes mes données',
                    style: TextStyle(
                      color: Color(0xFFAD0000),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 32,
            top: 419,
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 0,
                  child: Text(
                    'Modifier mes coordonnees',
                    style: TextStyle(
                      color: Color(0xFF5A5A5A),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 32,
            top: 481,
            child: Stack(
              children: [
                Positioned(
                  left: 27,
                  top: 0,
                  child: Text(
                    'Reinitialiser mon mot de passe',
                    style: TextStyle(
                      color: Color(0xFF5A5A5A),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 57,
            top: 351,
            child: SizedBox(
              width: 316,
              child: Text(
                'Compte Gratuit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF06668E),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}