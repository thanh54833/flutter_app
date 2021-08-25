import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/data/DatabaseUtils.dart';
import 'package:flutter_app/example/main/app/data/HandleMusicData.dart';
import 'package:flutter_app/example/main/app/data/MusicDatabase.dart';
import 'package:flutter_app/example/main/app/data/PlaylistHelper.dart';
import 'package:flutter_app/example/main/app/data/PlaylistModel.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

main() => runApp(App());

class App extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StateApp(),
      ),
    );
  }
}

class StateApp extends StatefulWidget {
  createState() => _StateApp();
}

class _StateApp extends State<StateApp> {
  build(BuildContext context) {
    // List<MusicModel> list = List.generate(40, (index) {
    //   return MusicModel("", "", "")
    //     ..id = index
    //     ..url = "url $index"
    //     ..name = "name $index"
    //     ..title = "title $index"
    //     ..artist = "artist $index"
    //     ..album = "album $index"
    //     ..mime = "mime $index"
    //     ..textEncoding = "textEncoding $index"
    //     ..picType = "picType $index"
    //     ..description = "description $index"
    //     ..base64 = "base64 $index"
    //     ..logo = "logo $index"
    //     ..logoMemory = "logoMemory $index"
    //     ..trackName = "trackName $index"
    //     ..authorName = "authorName $index"
    //     ..trackDuration = "trackDuration $index"
    //     ..duration = index;
    // });
    //
    // saveData(List<MusicModel> list) async {
    //   var data = DatabaseUtils.instance;
    //   await Future.wait([data.delete(), data.setData(list)]);
    // }
    //
    // var handleMusicData = HandleMusicData.instance;
    // //Todo :khi thanh click scan file ...
    // handleMusicData.musicData().then((listData) {
    //   "listData :... ${listData.length} ".Log();
    //   saveData(listData);
    // });

    List<PlaylistModel> list = [];

    "database :...".Log();

    List<int>.generate(10, (index) => index).forEach((element) {
      //"element :.. ${element}".Log();
      PlaylistModel playList = PlaylistModel()
        ..id = element
        ..tableName = "table_name_$element"
        ..countPlay = 42
        ..countFavorite = 98
        ..countDownload = 28
        ..name = "name"
        ..description = "description";
      list.add(playList);
    });
    var playlistHelper = PlaylistHelper.instance;
    playlistHelper?.deleteAll().then((value) {});
    playlistHelper?.setPlaylist(list).then((value) {
      "saveData :... ".Log();
    });
    playlistHelper?.getAll().then((value) {
      "playlistHelper.getAll():.. ${value.length} ".Log();
    });
    return Container();
  }
}
