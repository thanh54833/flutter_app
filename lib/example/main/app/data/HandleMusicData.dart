import 'dart:io';
import 'dart:typed_data';

import 'package:audiotagger/audiotagger.dart';
import 'package:flutter_app/example/main/common/FilesUtils.dart';
import 'package:media_metadata_plugin/media_metadata_plugin.dart';

import 'MusicDatabase.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

class HandleMusicData {
  HandleMusicData._privateConstructor();

  static final HandleMusicData instance = HandleMusicData._privateConstructor();
  List<MusicModel> Listdata = [];

  Future<void> _audioMetaData(path, index) async {
    var music = MusicModel("", "", "");
    //AudioMetaData
    //Future<AudioMetaData>  audioMetaData = await MediaMetadataPlugin.getMediaMetaData(path);
    //Future<Uint8List> pathByte = await _getPathBytes(path);
    _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    // ignore: missing_return
    //var wait = await
    await Future.wait([
      // ignore: missing_return
      MediaMetadataPlugin.getMediaMetaData(path).then((audioMetaData) {
        //"_audioMetaData :..".Log();
        music.album = audioMetaData.album;
        music.artist = audioMetaData.artistName;
        music.authorName = audioMetaData.authorName;
        music.trackName = audioMetaData.trackName;
        // int trackDuration = 0;
        // "audioMetaData :.. ${audioMetaData.artistName} "
        //         "_ ${audioMetaData.authorName} "
        //         "_ ${audioMetaData.trackName} "
        //         "_ ${audioMetaData.album} "
        //         "_ ${audioMetaData.mimeTYPE} "
        //     .Log();
        //"audioMetaData :.. ".Log();
        music.trackDuration =
            _printDuration(Duration(milliseconds: audioMetaData.trackDuration));
        music.duration = audioMetaData.trackDuration;
        music.mime = audioMetaData.mimeTYPE;
      }),
      // ignore: missing_return
      _getPathBytes(path).then((value) {
        //"_getPathBytes :.. ${value}".Log();
        if (value != null) {
          music.logoMemory = new String.fromCharCodes(value);
        }
      }),
    ]);

    music.id = index;
    music.url = path;
    if ((music.artist != null) && (music.artist != "")) {
      Listdata.add(music);
    }
    //return wait;
  }

  Future<Uint8List> _getPathBytes(String path) async {
    return await Audiotagger().readArtwork(path: path);
  }

  musicData() async {
    List<File> data = await FileUtils.internal().getStorageInfo(["mp3"]);
    Listdata.clear();
    List<Future<void>> listFuture = [];
    data.asMap().forEach((index, element) async {
      var path = element.absolute.path;
      // ignore: missing_return
      listFuture.add(_audioMetaData(path, index));
    });
    await Future.wait(listFuture);
    return Listdata;
  }
}
