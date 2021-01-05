import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// thanh chưa làm xong bài này ...
///thanh : Building beautiful UIs with Flutter , https://codelabs.developers.google.com/codelabs/flutter#0
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      title: "title",
      theme: ThemeData(
        // Add the 3 lines from here...
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        body: Center(
          child: Text("MyApp :..."),
        ),
      ),
    );
  }
}
