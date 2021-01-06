// framework
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';

// packages
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileUtils {

  static FileUtils _instance = new FileUtils.internal();
  FileUtils.internal();
  factory FileUtils() => _instance;

  filterFiles(List<String> extension) async {
    var root = await getExternalStorageDirectory();
    var fm = FileManager(root: root);
    var files =
        await fm.filesTree(excludedPaths: ["/storage/emulated/0/Android"]);
    isContain(String string) {
      var isContains = true;
      extension.forEach((element) {
        if (!string.contains(element)) {
          isContains = false;
        }
      });
      return isContains;
    }

    List<File> data = files;
    List<File> listMp3 =
        data.where((element) => isContain(element.absolute.path)).toList();
    return listMp3;
  }
}
