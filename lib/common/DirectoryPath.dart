import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryPath extends ChangeNotifier{
  List<String> filenames = [''];
  getPath() async {
    final Directory? tempDir = await getExternalStorageDirectory();
    final filePath = Directory("${tempDir!.path}/exovite/files");
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