import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Container(
      child: Column(
        children: [
          Flexible(
              child: Container(
            color: Colors.red,
          )),
          Flexible(
              child: Container(
            color: Colors.blue,
          )),
          Flexible(
              child: Container(
            color: Colors.yellow,
          ))
        ],
      ),
    );
  }
}
