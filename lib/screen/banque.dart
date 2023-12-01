import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:exovite/common/CheckPermission.dart';
import 'package:exovite/common/Classe.dart';
import 'package:exovite/common/DirectoryPath.dart';
import 'package:exovite/data/Data.dart';
import 'package:exovite/screen/Accueil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;

class banques extends StatelessWidget{
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("asset/ban.png",height: 100,width: 100,),
              Text(
                'Banque',
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
          child: Container(
            margin: EdgeInsetsDirectional.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Text("Classe",
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
                        List<Matiere> mesmatiere = List.of(data.maClasse.Matieres);
                        List<String> listem = [""];
                        Matiere toutMatiere = Matiere('Tout', 'Le tout ', 'asset/book.png');
                        mesmatiere.insert(0, toutMatiere);
                        mesmatiere.forEach((element) {
                          listem.add(element.nom);
                        });
                        if(snapshot.connectionState==ConnectionState.waiting){
                          CircularProgressIndicator();
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(onPressed: (){}, child: Text(data.maClasse.nom,style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(6, 102, 142, 1),
                            )
                            ),
                            ElevatedButton(onPressed: (){}, child: Text("filtres",style: TextStyle(color: Color.fromRGBO(6, 102, 142, 1)),),style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            )
                            ),
                          ],
                        );

                      } );
                    }),
                Consumer<Data>(
                builder: (context, data, child) {
                    return Container(
                 color: Colors.white, // Couleur de fond pour le reste de l'écran
                 child: SingleChildScrollView(
                     child: UserInformation( classe: data.me.classe,)
                 ),
               );
            }),

              ],
            ),
          ),
        ),
      ],
    );
  }
}





class UserInformation extends StatefulWidget {
  final String classe;
  UserInformation({super.key, required this.classe});
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  bool isPermission = false;
  //pour verifier les permission
  var checkAllPermissions = CheckPermission();

  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }
  void initState() {
    super.initState();
    checkPermission();
  }



  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('banques').where("classe" ,isEqualTo: widget.classe ).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Un problème');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return snapshot.data!.docs.isEmpty ? Center(
          child: Container(),
        ) : Material(
          child: Container(
            color: Color.fromRGBO(235, 242, 250, 1),
            height: MediaQuery.of(context).size.height - 350,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection('banques').doc(snapshot.data!.docs[index].id).collection("sujet").get(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> messujetSnapshot) {
                    if (messujetSnapshot.hasError) {
                      return const Text('Un problème');
                    }
                    if (messujetSnapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Container(
                      height: MediaQuery.of(context).size.height - 350,
                      child: ListView.builder(
                        itemCount: messujetSnapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int subIndex) {
                          Map<String, dynamic> subData = messujetSnapshot.data!.docs[subIndex].data() as Map<String, dynamic>;
                          return Container(
                            margin: EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xFF06668E)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TileList(fileUrl: subData['url'], title: subData['nom']),
                          );
                        },
                      ),
                    );

                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

}


class TileList extends StatefulWidget {
  TileList({super.key, required this.fileUrl, required this.title});
  final String fileUrl;
  final String title;

  @override
  State<TileList> createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  bool dowloading = false;
  bool finish = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  String nom = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();

  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = await getAvailableFileName(storePath, nom);
    setState(() {
      dowloading = true;
      progress = 0;
    });

    try {
      await Dio().download(widget.fileUrl, filePath,
          onReceiveProgress: (count, total) {
            setState(() {
              progress = (count / total);
            });
          }, cancelToken: cancelToken);
      setState(() {
        dowloading = false;
        fileExists = true;
        finish = true;
        DirectoryPath getPathFiles(BuildContext context) {
          return Provider.of<DirectoryPath>(context, listen: false);
        }
        getPathFiles(context).notify();
      });
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }
  Future<String> getAvailableFileName(String basePath, String desiredName) async {
    int suffix = 1;
    String fileName = '$basePath/$desiredName';

    while (await File(fileName).exists()) {
      suffix++;
      fileName = '$basePath/$desiredName $suffix';
    }

    return fileName;
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/+$nom';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  openfile() {
    OpenFile.open(filePath);
    print("fff $filePath");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = Path.basename(widget.fileUrl);
      nom = widget.title;
    });
    checkFileExit();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.title),
        leading: Icon(Icons.file_open,color: Color(0xFF06668E)),
        trailing: IconButton(
            onPressed: () {
              startDownload();
            },
            icon : dowloading
                ? Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 3,
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF06668E)),
                ),
                Text(
                  "${(progress * 100).toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
                : finish==false ? Icon((Icons.download),color : Color(0xFF06668E)) : Icon((Icons.download),color : Colors.green)
        )
    )
    ;
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
