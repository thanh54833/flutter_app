import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wave_generator/wave_generator.dart';

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
  _fun() async {
    var generator = WaveGenerator(
        /* sample rate */
        44100,
        BitDepth.Depth8bit);
    var note = Note(
        /* frequency */
        220,
        /* msDuration */ 3000,
        /* waveform */ Waveform.Triangle,
        /* volume */ 0.5);
    var file = new File('output.wav');
    List<int> bytes = <int>[];
    await for (int byte in generator.generate(note)) {
      bytes.add(byte);
    }
    file.writeAsBytes(bytes, mode: FileMode.append);
  }

  build(BuildContext context) {
    _fun();
    return Container(

    );
  }
}
