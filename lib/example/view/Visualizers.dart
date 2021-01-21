import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_visualizers/Visualizers/BarVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/CircularBarVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/CircularLineVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/LineBarVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/LineVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/MultiWaveVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(' Example'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              splashColor: Colors.pinkAccent,
              color: Colors.black,
              child: new Text(
                "Play Song",
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaySong()),
                );
              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaySong extends StatefulWidget {
  @override
  _VisState createState() => _VisState();
}

class _VisState extends State<PlaySong> {
  int playerID;
  String selected = 'LineBarVisualizers';
  final List<String> _dropdownValues = [
    "MultiWaveVisualizer",
    "LineVisualizer",
    "LineBarVisualizer",
    "CircularLineVisualizer",
    "CircularBarVisualizer",
    "BarVisualizer"
  ];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    methodCalls.playSong();

    var audioPlayer = AudioPlayer();
    audioPlayer.setFilePath(
        "/storage/emulated/0/NCT/DiDuDuaDi-BichPhuong-6059493.mp3");
    //audioPlayer.
    audioPlayer.play();

    // var mediaPlayer =
    //     MediaPlayerPlugin.create(isBackground: true, showNotification: true);
    // mediaPlayer.setSource(
    //     MediaFile(source: "https://luan.xyz/files/audio/ambient_c_motion.mp3"));
    // mediaPlayer.play();

    int sessionId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      sessionId = await methodCalls.getSessionId();
    } on Exception {
      sessionId = null;
    }
    setState(() {
      // var uu = audioPlayer.androidAudioSessionIdStream;
      // uu.single.then((value) {
      //   "value :.. ${value} ".Log();
      // });
      // "audioPlayer.androidAudioSessionId; :.. ${audioPlayer.androidAudioSessionId} "
      //     .Log();
      // playerID = audioPlayer.androidAudioSessionId;

      var ss = audioPlayer.androidAudioSessionId;
      audioPlayer.androidAudioSessionIdStream.forEach((element) {
        "element :... ${element} ".Log();
        H
      }); //then((id){});
      "sessionId :.. ${sessionId} __ ${ss} ".Log();

      playerID = sessionId;
    });
  }

  String newValue;

  Widget dropdownWidget() {
    return DropdownButton(
      //map each value from the lIst to our dropdownMenuItem widget
      items: _dropdownValues
          .map((value) =>
          DropdownMenuItem(
            child: Text(value),
            value: value,
          ))
          .toList(),
      onChanged: (String value) {
        newValue = value;
        setState(() {
          selected = value;
        });
      },
      //this wont make dropdown expanded and fill the horizontal space
      isExpanded: false,
      //make default value of dropdown the first value of our list
      value: newValue,
      hint: Text('choose'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text(' Visulizer '),
            actions: <Widget>[
              dropdownWidget(),
            ],
          ),
          body: playerID != null
              ? selected == 'MultiWaveVisualizer'
              ? new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new MultiWaveVisualizer(
                  waveData: wave,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          )
              : selected == 'LineVisualizer'
              ? new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new LineVisualizer(
                  waveData: wave,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          )
              : selected == 'LineBarVisualizer'
              ? new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new LineBarVisualizer(
                  waveData: wave,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          )
              : selected == 'CircularLineVisualizer'
              ? new Visualizer(
            builder: (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new CircularLineVisualizer(
                  waveData: wave,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          )
              : selected == 'CircularBarVisualizer'
              ? new Visualizer(
            builder:
                (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new CircularBarVisualizer(
                  waveData: wave,
                  height:
                  MediaQuery
                      .of(context)
                      .size
                      .height,
                  width:
                  MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          )
              : new Visualizer(
            builder:
                (BuildContext context, List<int> wave) {
              return new CustomPaint(
                painter: new BarVisualizer(
                  waveData: wave,
                  height:
                  MediaQuery
                      .of(context)
                      .size
                      .height,
                  width:
                  MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.blueAccent,
                ),
                child: new Container(),
              );
            },
            id: playerID,
          )
              : Center(
            child: Text('No SessionID'),
          ),
        ));
  }
}

class methodCalls {
  static const MethodChannel _channel = const MethodChannel('calls');

  static Future<int> getSessionId() async {
    int session;
    try {
      final int result = await _channel.invokeMethod('getSessionID');
      session = result;
    } on PlatformException catch (e) {
      session = null;
    }
    return session;
  }

  static playSong() async {
    _channel.invokeMethod('playSong');
  }
}
