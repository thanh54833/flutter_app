import 'package:flutter_app/example/main/app/data/MusicDatabase.dart';

class TablePlayList {
  static String columnId = "_id";
  static String columnTableName = "tableName";
  static String columnCountPlay = "countPlay";
  static String columnCountFavorite = "countFavorite";
  static String columnCountDownload = "countDownload";
  static String columnName = "name";
  static String columnDescription = "description";
}

class PlaylistModel {
  int id = 0;
  String tableName = "";
  int countPlay = 42;
  int countFavorite = 98;
  int countDownload = 28;
  String name = "";
  String description = "";

  PlaylistModel();

  PlaylistModel.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    tableName = map[TablePlayList.columnTableName];
    countPlay = map[TablePlayList.columnCountPlay];
    countFavorite = map[TablePlayList.columnCountFavorite];
    countDownload = map[TablePlayList.columnCountDownload];
    name = map[columnName];
    description = map[columnDescription];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      TablePlayList.columnTableName: tableName,
      TablePlayList.columnCountPlay: countPlay,
      TablePlayList.columnCountFavorite: countFavorite,
      TablePlayList.columnCountDownload: countDownload,
      TablePlayList.columnName: name,
      TablePlayList.columnDescription: description,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
