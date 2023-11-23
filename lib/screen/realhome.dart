import 'package:exovite/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class Realhome extends StatelessWidget {
  late PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      Accueil(),
      CustomTopContainer(),
      CustomTopContainer(),
      CustomTopContainer(),
      CustomTopContainer()
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
    return PersistentTabView(
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
    );
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromRGBO(235, 242, 250, 1),
                  child: const Text('A',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Color.fromRGBO(6, 102, 142, 1),
                  ),),
                ),
              ),
              Expanded(
                child:  Text(
                  'Ravi de vous revoir Diakite',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,

                  ),
                ),
              ),
              Expanded(
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(235, 242, 250, 1),
                  child: const Text('AH'),
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