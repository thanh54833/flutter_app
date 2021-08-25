// framework
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';

// packages
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter File Manager Demo"),
          ),
          body: FutureBuilder(
            future: _files(["mp3"]),
            // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print("data :... ${snapshot.data.length}");

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Press button to start.');
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Text('Awaiting result...');
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  return snapshot.data != null
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) => Card(
                                  child: ListTile(
                                title: Text(snapshot.data[index].absolute.path),
                                subtitle: Text(
                                    "Extension: ${p.extension(snapshot.data[index].absolute.path).replaceFirst('.', '')}"), // getting extension
                              )))
                      : Center(
                          child: Text("Nothing!"),
                        );
              }
            },
          )),
    );
  }

  _files(List<String> extension) async {
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
