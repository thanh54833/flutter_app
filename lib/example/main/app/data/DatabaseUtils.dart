import 'package:sqflite/sqflite.dart';

import 'MusicDatabase.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

class DatabaseUtils {
  // Make this a singleton class.
  DatabaseUtils._privateConstructor();

  static final DatabaseUtils instance = DatabaseUtils._privateConstructor();

  Future insert(music) async {
    MusicDatabaseHelper helper = MusicDatabaseHelper.instance;
    int id = await helper.insert(music);
  }

  Future getAll() async {
    List<MusicModel> data = [];
    Database database = await MusicDatabaseHelper.instance.database;
    var word = await database.query(tableMusic);
    word.forEach((element) {
      data.add(MusicModel.fromMap(element));
    });
    return data;
  }

  Future delete() async {
    Database helper = await MusicDatabaseHelper.instance.database;
    await helper.delete(tableMusic);
  }

  Future setData(List<MusicModel> listData) async {
    List<Future<void>> futures = [];
    listData.forEach((music) {
      futures.add(insert(music));
    });
    await Future.wait(futures);
    return true;
  }
}
