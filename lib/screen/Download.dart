import 'package:exovite/common/Classe.dart';
import 'package:exovite/common/DirectoryPath.dart';
import 'package:exovite/data/Data.dart';
import 'package:exovite/screen/Accueil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;

class Download extends StatelessWidget{
  var getPathFile = DirectoryPath();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150.0,
          width: MediaQuery.of(context).size.width,// Hauteur fixe du conteneur en haut
          decoration: BoxDecoration(
            color: Color.fromRGBO(6, 102, 142, 1), // Couleur du conteneur
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0), // Bordure en bas à gauche
              bottomRight: Radius.circular(20.0), // Bordure en bas à droite
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("asset/tel.png",height: 100,width: 100,),
              Text(
                'Mes Telechargements',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Autres widgets que vous souhaitez ajouter en dessous du conteneur
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Container(
                color: Colors.white, // Couleur de fond pour le reste de l'écran
                child: SingleChildScrollView(
                  child: Consumer<DirectoryPath>(builder: (BuildContext context, DirectoryPath value, child) {
                    return FutureBuilder(
                        future: value.listFiles(),
                        builder : (context, snapshot){
                          if(snapshot.connectionState==ConnectionState.waiting){

                          }
                          if (snapshot.hasError) {
                            return const Text('Un probleme');
                          }
                          if(value.filenames.isEmpty){
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              color: Color.fromRGBO(235, 242, 250, 1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("asset/ntel.png"),
                                  Text("Pas de telechargement",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,

                                  ),)
                                ],
                              ),
                            );
                          }else{
                            List<String> filenames = value.filenames;
                            print(filenames.first);
                            return Container(
                              height: MediaQuery.of(context).size.height -390,
                              child:  ListView.builder(
                                itemCount: filenames.length,
                                itemBuilder: (context, int index) {
                                  return Material(
                                      child: GestureDetector(
                                          onTap:  () {
                                            OpenFile.open(filenames[index]);
                                          },
                                          child: Container(
                                            margin: EdgeInsetsDirectional.only(start: 10,end: 10,bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(235, 242, 250, 1), // Couleur de fond du Container
                                              border: Border.all(color: Color(0xFF06668E)), // Couleur de la bordure
                                              borderRadius: BorderRadius.circular(10.0), // Ajustez le rayon de la bordure selon vos besoins
                                            ),
                                            child: ListTile(
                                              leading: Icon(Icons.file_open, color: Color(0xFF06668E)),
                                              title: Text(Path.basename(filenames[index])),
                                            ),
                                          )
                                      )
                                  );

                                },

                              ),
                            )
                            ;
                          }

                        });
                  },

                  )
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}