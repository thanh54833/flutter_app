// database table and column names
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/example/main/app/data/TABLE_DATABASE.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String columnId = '_id';
final String columnUrl = 'url';
final String columnName = 'name';
final String columnTitle = 'title';
final String columnArtist = 'artist';
final String columnAlbum = 'album';
final String columnTextEncoding = 'textEncoding';
final String columnPicType = 'picType';
final String columnDescription = 'description';
final String columnBase64 = 'base64';
final String columnLogo = 'logo';
final String columnLogoMemory = 'logoMemory';
final String columnTrackName = 'trackName';
final String columnAuthorName = 'authorName';
final String columnTrackDuration = 'trackDuration';
final String columnDuration = 'duration';

class MusicModel {
  int id = 0;
  String url = "";
  String name = "";
  String title = "";
  String artist = "";
  String album = "";
  String mime = "";
  String textEncoding = "";
  String picType = "";
  String description = "";
  String base64 = "";
  String logo = "";
  String logoMemory = "";
  String trackName = "";
  String authorName = "";
  String trackDuration = "";
  int duration = 0;

  ValueNotifier<bool> isSelected = ValueNotifier(false);

  MusicModel(this.url, this.name, this.description);

  // convenience constructor to create a Word object
  MusicModel.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    url = map[columnUrl];
    name = map[columnName];
    title = map[columnTitle];
    artist = map[columnArtist];
    album = map[columnAlbum];
    textEncoding = map[columnTextEncoding];
    picType = map[columnPicType];
    description = map[columnDescription];
    base64 = map[columnBase64];
    logo = map[columnLogo];
    logoMemory = map[columnLogoMemory];
    trackName = map[columnTrackName];
    authorName = map[columnAuthorName];
    trackDuration = map[columnTrackDuration];
    duration = map[columnDuration];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUrl: url,
      columnName: name,
      columnTitle: title,
      columnArtist: artist,
      columnAlbum: album,
      columnTextEncoding: textEncoding,
      columnPicType: picType,
      columnDescription: description,
      columnBase64: base64,
      columnLogo: logo,
      columnLogoMemory: logoMemory,
      columnTrackName: trackName,
      columnAuthorName: authorName,
      columnTrackDuration: trackDuration,
      columnDuration: duration,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class MusicDatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MusicDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  MusicDatabaseHelper._privateConstructor();

  static final MusicDatabaseHelper instance =
      MusicDatabaseHelper._privateConstructor();

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
              CREATE TABLE ${AppConfig.table_music_name} (
                $columnId INTEGER PRIMARY KEY,
                $columnUrl TEXT,
                $columnName TEXT,
                $columnTitle TEXT,
                $columnArtist TEXT,
                $columnTextEncoding TEXT,
                $columnPicType TEXT,
                $columnAlbum TEXT,
                $columnDescription TEXT,
                $columnBase64 TEXT,
                $columnLogo TEXT,
                $columnLogoMemory TEXT,
                $columnTrackName TEXT,
                $columnAuthorName TEXT,
                $columnTrackDuration TEXT,
                $columnDuration INTEGER                 
            )''');
  }

  Future<int> insert(MusicModel music) async {
    Database db = await database;
    int id = await db.insert(AppConfig.table_music_name, music.toMap());
    return id;
  }

  Future<MusicModel?> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(AppConfig.table_music_name,
        columns: [
          columnId,
          columnUrl,
          columnName,
          columnTitle,
          columnArtist,
          columnTextEncoding,
          columnPicType,
          columnDescription,
          columnBase64,
          columnAlbum,
          columnLogo,
          columnLogoMemory,
          columnTrackName,
          columnAuthorName,
          columnTrackDuration,
          columnDuration
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return MusicModel.fromMap(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<MusicModel>> getAll() async {
    List<MusicModel> data = [];
    Database database = await MusicDatabaseHelper.instance.database;
    var word = await database.query(AppConfig.table_music_name);
    word.forEach((element) {
      data.add(MusicModel.fromMap(element));
    });
    return data;
  }

  Future deleteAll() async {
    Database helper = await MusicDatabaseHelper.instance.database;
    await helper.delete(AppConfig.table_music_name);
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}
