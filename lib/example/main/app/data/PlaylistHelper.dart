import 'dart:io';

import 'package:flutter_app/example/main/app/data/PlaylistModel.dart';
import 'package:flutter_app/example/main/app/data/TABLE_DATABASE.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PlaylistHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "PlaylistDatabase2.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 2;

  // Make this a singleton class.
  PlaylistHelper._privateConstructor();

  static final PlaylistHelper? instance = PlaylistHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
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
              CREATE TABLE ${TABLE_DATABASE.table_playlist} (
                ${TablePlayList.columnId} INTEGER PRIMARY KEY,
                ${TablePlayList.columnTableName} TEXT,
                ${TablePlayList.columnCountPlay} INTEGER,
                ${TablePlayList.columnCountFavorite} INTEGER,     
                ${TablePlayList.columnCountDownload} INTEGER,
                ${TablePlayList.columnName} TEXT,   
                ${TablePlayList.columnDescription} TEXT            
            )''');
  }

  Future<List<PlaylistModel>> getAll() async {
    List<PlaylistModel> data = [];
    Database? database = await PlaylistHelper.instance?.database;
    var word = await database?.query(TABLE_DATABASE.table_playlist);
    word?.forEach((element) {
      data.add(PlaylistModel.fromMap(element));
    });
    return data;
  }

  Future insert(PlaylistModel music) async {
    Database db = await database;
    await db.insert(TABLE_DATABASE.table_playlist, music.toMap());
  }

  Future<int?> setPlaylist(List<PlaylistModel> musics) async {
    Database db = await database;
    List<Future<void>> listInsert = [];
    musics.forEach((music) {
      listInsert.add(db.insert(TABLE_DATABASE.table_playlist, music.toMap()));
    });
    await Future.wait(listInsert);
  }

  Future deleteAll() async {
    Database? helper = await PlaylistHelper.instance?.database;
    await helper?.delete(TABLE_DATABASE.table_playlist);
  }
}
