import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/data/MusicDatabase.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

main() => runApp(LocalDatabase());

class LocalDatabase extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StateLocalDatabase(),
      ),
    );
  }
}

class StateLocalDatabase extends StatefulWidget {
  createState() => _StateLocalDatabase();
}

class _StateLocalDatabase extends State<StateLocalDatabase> {
  // _insert(word) async {
  //   DatabaseHelper helper = DatabaseHelper.instance;
  //   int id = await helper.insert(word);
  //   print('inserted row: $id');
  // }
  //
  // _getData(int rowId) async {
  //   DatabaseHelper helper = DatabaseHelper.instance;
  //   Word word = await helper.queryWord(rowId);
  //   if (word == null) {
  //     print('read row $rowId: empty');
  //   } else {
  //     print('read row $rowId: ${word.word} ${word.frequency}');
  //   }
  // }
  //
  // _getAll() async {
  //   List<Word> data = [];
  //   Database database = await DatabaseHelper.instance.database;
  //   var word = await database.query(tableWords);
  //   word.forEach((element) {
  //     data.add(Word.fromMap(element));
  //   });
  //   return data;
  // }
  //
  // _deleteAll() async {
  //   Database helper = await DatabaseHelper.instance.database;
  //   await helper.delete(tableWords);
  // }

  _setData(List<MusicModel> musis) async {
    // musis.forEach((music) {
    //
    //   _insert(music);
    //
    // });

    // List<Future<void>> inserts=[];
    // musis.forEach((element) {
    //   inserts.add(_insert(element));
    // });
    // Future.wait(inserts);
  }

  _insert(music) async {
    MusicDatabaseHelper helper = MusicDatabaseHelper.instance;
    int id = await helper.insert(music);
    //print('inserted row: $id');
    "_insert :... ${id}".Log();
  }

  _getAll() async {
    List<MusicModel> data = [];
    Database database = await MusicDatabaseHelper.instance.database;
    var word = await database.query(tableMusic);
    word.forEach((element) {
      data.add(MusicModel.fromMap(element));
    });
    return data;
  }

  _delete() async {
    Database helper = await MusicDatabaseHelper.instance.database;
    await helper.delete(tableMusic);
  }

  _setdata() async {
    var music = MusicModel("url", "name", "description");
    music.id = 1;
    music.url = "url";
    music.name = "name";
    music.title = "title";
    music.artist = "artist";
    music.album = "album";
    music.mime = "mime";
    music.textEncoding = "textEncoding";
    music.picType = "picType";
    music.description = "description";
    music.base64 = "base64";
    music.logo = "logo";
    music.trackName = "trackName";
    music.authorName = "authorName";
    music.trackDuration = "trackDuration";
    List<MusicModel> listData = [];
    for (var i = 0; i < 3; i++) {
      //children.add(new ListTile());
      var empty = music;
      empty.id = i;
      listData.add(empty);
      // await Future.delayed(Duration(seconds: 1), () {
      //   _insert(empty);
      // });
    }
    List<Future<void>> inserts = [];
    listData.forEach((element) {
      inserts.add(_insert(element));
    });
    await Future.wait(inserts);
    //return true;
  }

  _setDataV2() async {
    var list = List<int>.generate(10, (index) => index);
    List<Future<void>> futures = [];
    list.forEach((index) {
      var music = MusicModel("url", "name", "description");
      music.id = index;
      music.url = "url";
      music.name = "name";
      music.title = "title";
      music.artist = "artist";
      music.album = "album";
      music.mime = "mime";
      music.textEncoding = "textEncoding";
      music.picType = "picType";
      music.description = "description";
      music.base64 = "base64";
      music.logo = "logo";
      music.trackName = "trackName";
      music.authorName = "authorName";
      music.trackDuration = "trackDuration";
      futures.add(_insert(music));
    });

    await Future.wait(futures);

    return true;
  }

  build(BuildContext context) {
    // _deleteAll().then((value) {
    //
    // });
    //
    // Word word = Word();
    // word.word = 'hello';
    // word.frequency = 15;
    //
    // _insert(word);
    // _insert(word);
    //
    // _getAll().then((data) {
    //   //List<Word> dataCast = data;
    //   //"data.length ${dataCast.length}".Log();
    // });
    var music = MusicModel("url", "name", "description");
    music.id = 1;
    music.url = "url";
    music.name = "name";
    music.title = "title";
    music.artist = "artist";
    music.album = "album";
    music.mime = "mime";
    music.textEncoding = "textEncoding";
    music.picType = "picType";
    music.description = "description";
    music.base64 = "base64";
    music.logo = "logo";
    music.trackName = "trackName";
    music.authorName = "authorName";
    music.trackDuration = "trackDuration";

    _delete().then((value) => {});

    _setDataV2().then((result) {
      "result :.. ${result} ".Log();
      if (result == true) {
        _getAll().then((_data) {
          "data.length :... ${_data.length} ".Log();
        });
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      _getAll().then((_data) {
        List<MusicModel> data = _data;
        " data.length :.. ${data.length}".Log();
      });
    });
    return Container();
  }
}

// database table and column names
final String tableWords = 'words';
final String tableMusic = '_tableMusic';

final String columnId = '_id';
final String columnWord = 'word';
final String columnFrequency = 'frequency';

// data model class
class Word {
  int id;
  String word;
  int frequency;

  Word();

  // convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    word = map[columnWord];
    frequency = map[columnFrequency];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnWord: word, columnFrequency: frequency};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableWords (
                $columnId INTEGER PRIMARY KEY,
                $columnWord TEXT NOT NULL,
                $columnFrequency INTEGER NOT NULL
              )
              ''');
  }

  // Database helper methods:
  Future<int> insert(Word word) async {
    Database db = await database;
    int id = await db.insert(tableWords, word.toMap());
    return id;
  }

  Future<Word> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords,
        columns: [columnId, columnWord, columnFrequency],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return null;
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}
