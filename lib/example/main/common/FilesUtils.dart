// framework
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';

// packages
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

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

    "files size :.. ${files.length} ".Log();
    List<File> data = files;
    List<File> listMp3 =
        data.where((element) => isContain(element.absolute.path)).toList();

    return listMp3;
  }

  getStorageInfo(List<String> extensions) async {
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0]
        .rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    var files = await fm.filesTree(
        //set fm.dirsTree() for directory/folder tree list
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: extensions //optional, to filter files, remove to list all,
        //remove this if your are grabbing folder list
        );
    "files :... ${files.length} ".Log();
    return files;
  }
}
