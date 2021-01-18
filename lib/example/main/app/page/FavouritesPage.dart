import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audiotagger/audiotagger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
import 'package:flutter_app/example/main/app/Themes.dart';
import 'package:flutter_app/example/main/app/data/DatabaseUtils.dart';
import 'package:flutter_app/example/main/app/data/MusicDatabase.dart';
import 'package:flutter_app/example/main/app/model/SongModel.dart';
import 'package:flutter_app/example/main/common/DialogCommon.dart';
import 'package:flutter_app/example/main/common/FilesUtils.dart';
import 'package:flutter_app/example/main/common/StatefulWrapper.dart';
import 'package:flutter_app/example/music/MusicModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:media_metadata_plugin/media_metadata_plugin.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:media_store/media_store.dart';
import 'package:intl/intl.dart';

class FavouritesPage extends StatefulWidget {
  Function(MusicModel) onCLick;
  Function onClickScan;

  FavouritesPage({
    @required this.onCLick,
  });

  createState() => _FavouritesPage();
}

class _FavouritesPage extends State<FavouritesPage> {
  List<MusicModel> data = [];
  var isInitState = false;

  _getMusicModel(path) async {
    var audioMetaData = await MediaMetadataPlugin.getMediaMetaData(path);
    var music = MusicModel("", "", "");
    music.url = path;
    music.album = audioMetaData.album;
    music.artist = audioMetaData.artistName;
    music.authorName = audioMetaData.authorName;
    music.trackName = audioMetaData.trackName;
    music.trackDuration = "${audioMetaData.trackDuration}";
    music.mime = audioMetaData.mimeTYPE;
    return music;
  }

  _audioMetaData(path, index) async {
    var audioMetaData = await MediaMetadataPlugin.getMediaMetaData(path);
    var pathByte = await _getPathBytes(path);
    var music = MusicModel("", "", "");
    music.id = index;
    music.url = path;
    music.album = audioMetaData.album;
    music.artist = audioMetaData.artistName;
    music.authorName = audioMetaData.authorName;
    music.trackName = audioMetaData.trackName;
    _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    "pathByte.toString() :... ${pathByte.toString()} ".Log();

    if (pathByte != null) {
      music.logoMemory = new String.fromCharCodes(pathByte);
    }

    music.trackDuration =
        _printDuration(Duration(milliseconds: audioMetaData.trackDuration));
    music.mime = audioMetaData.mimeTYPE;
    if ((music.artist != null) && (music.artist != "")) {
      this.data.add(music);
    }
  }

  _musicData() async {
    List<File> data = await FileUtils.internal().getStorageInfo(["mp3"]);
    List<Future<void>> listFuture = [];
    data.asMap().forEach((index, element) async {
      var path = element.absolute.path;
      listFuture.add(_audioMetaData(path, index));
    });
    await Future.wait(listFuture);
    DateTime end = DateTime.now();
    return data;
  }

  _handleDataLocal(List<MusicModel> data) async {
    var database = DatabaseUtils.instance;
    List<Future<void>> list = [database.delete(), database.setData(data)];
    await Future.wait(list);
    return true;
  }

  _getPathBytes(String path) async {
    return await Audiotagger().readArtwork(path: path);
  }

  initState() {
    super.initState();
    "_FavouritesPage :.. initState :.. ".Log();
    //Todo : when start screen home check data local ..
    if (isInitState == false) {
      var database = DatabaseUtils.instance;
      database.getAll().then((data) {
        //"data :.. ${data.length} ".Log();
        if (data.length > 0) {
          this.data.clear();
          setState(() {
            this.data = data;
          });
        }
      });
      isInitState = true;
    }
  }

  build(BuildContext context) {
    "_FavouritesPage :.. build :.. ".Log();

    widget.onClickScan = () {
      this.data.clear();
      //Todo :khi thanh click scan file ...
      _musicData().then((value) {
        //"value :... ${value.length}".Log();
        _handleDataLocal(data).then((value) {
          "_handleDataLocal :... ${value} ".Log();
        });
        setState(() {});
      });
    };

    return Scaffold(
      backgroundColor: LocalColor.Transparent,
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: (data.length == null) ? 0 : data.length,
          itemBuilder: (context, index) {
            var item = data[index];

            Uint8List _getUnit8List(String logo) {
              return new Uint8List.fromList(logo.codeUnits);
            }

            var _imagesLogo = _getUnit8List(item.logoMemory);
            return Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  child: Row(
                    //direction: Axis.horizontal
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Container(
                            child: Image.memory(
                              _imagesLogo,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        //alignment: Alignment.center,
                      ),
                      Container(
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              (item.artist != null) ? item.artist : "",
                              style: Themes.TextStyle_Small_Bold,
                            ),
                            Container(
                              child: Text(
                                (item.artist != null) ? item.artist : "",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                              margin: EdgeInsets.only(top: 2),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 5, right: 5),
                        //padding: EdgeInsets.only(bottom: 8),
                      ),
                      Expanded(
                          child: Container(
                        child: Wrap(
                          children: [
                            Container(
                              child: Icon(
                                Icons.contactless_outlined,
                                size: 22,
                              ),
                              alignment: Alignment.centerRight,
                            ),
                            Container(
                              child: Text(item.trackDuration,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black26)),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(top: 5),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(right: 8),
                      )),
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            child: IconButton(
                              icon: Icon(Icons.more_horiz),
                              onPressed: () {},
                              padding: EdgeInsets.all(0),
                            ),
                            color: Colors.white54,
                          ),
                        ),
                        height: 35,
                        width: 35,
                      )
                    ],
                  ),
                  color: LocalColor.Primary_20,
                  padding: EdgeInsets.all(8),
                ),
              ),
              margin:
                  EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
            ).setOnClick(() => widget.onCLick(item));
          },
        ),
        padding: EdgeInsets.only(bottom: 0),
      ),
    );
  }
}

class AnimatedListItem extends StatefulWidget {
  final int index;

  AnimatedListItem(this.index, {Key key}) : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;

  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: widget.index * 100), () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 1000),
        padding: _animate
            ? const EdgeInsets.all(4.0)
            : const EdgeInsets.only(top: 10),
        child: Container(
          constraints: BoxConstraints.expand(height: 100),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.index.toString(),
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
