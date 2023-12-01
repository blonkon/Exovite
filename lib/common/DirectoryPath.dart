import 'dart:io';

import 'package:exovite/data/Data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DirectoryPath extends ChangeNotifier{
  List<String> filenames = [''];
  getPath() async {
    String? id = "0";
    if (FirebaseAuth.instance.currentUser != null) {
     id = FirebaseAuth.instance.currentUser?.uid;
      //await FirebaseAuth.instance.signOut();
    }
    print("Lonpooooo"+id!);
    final Directory? tempDir = await getExternalStorageDirectory();
    final filePath = Directory("${tempDir!.path}/exovite/files/${id!}");
    if (await filePath.exists()) {
      return filePath.path;
    } else {
      await filePath.create(recursive: true);
      return filePath.path;
    }

  }
  Future<List<String>> listFiles() async {
    final String path = await getPath();
    final Directory directory = Directory(path);
    final List<FileSystemEntity> files = directory.listSync();

    this.filenames = [];

    for (var file in files) {
      if (file is File) {
        this.filenames.add(file.path);
      }
    }

    // Trier la liste par date de modification (du plus récent au plus ancien)
    this.filenames.sort((a, b) {
      File fileA = File(a);
      File fileB = File(b);
      return fileB.lastModifiedSync().compareTo(fileA.lastModifiedSync());
    });
    return this.filenames;
  }
  void notify() {
    notifyListeners();
  }
}