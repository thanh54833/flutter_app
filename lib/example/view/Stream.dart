import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

main() {
  //"main :.. ".Log();
  return runApp(App());
}

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
  createState() => _StatseApp();
}

class _StatseApp extends State<StateApp> {
  @override
  void initState() {
    super.initState();
    print("Creating a sample stream...");
    Stream<String> stream = new Stream.fromFuture(getData());
    print("Created the stream");
    stream.listen((data) {
      print("DataReceived: " + data);
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });
    print("code controller is here");
  }

  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 5)); //Mock delay
    print("Fetched Data");
    return "This a test data";
  }

  build(BuildContext context) {
    return Container();
  }
}

class Model {
  var name = "";
  var age = 20;

  Model(this.name, this.age);

  @override
  String toString() {
    return 'Model{name: $name, age: $age}';
  }
}
