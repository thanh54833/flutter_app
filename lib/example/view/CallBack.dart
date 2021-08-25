import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Function()? onCLick;

  @override
  Widget build(BuildContext context) {
    var view = StateApp();

    view.setOnClick(onCLick!);

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Wrap(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Center(
                    child: Text("on Click screen 1 :...").setOnClick(() {
                      onCLick!();
                    }),
                  ),
                ),
                view
              ],
            ),
          ),
          height: double.infinity,
          color: Colors.black,
        ),
      ),
    );
  }
}

class StateApp extends StatefulWidget {
  Function()? onCLick;

  // Function setOnClick(Function() _onCLick) {
  //   onCLick = _onCLick;
  // }
  StateApp({this.onCLick});

  createState() => _StateApp();
}

class _StateApp extends State<StateApp> {

  // onCLick=(){
  //
  // }


  build(BuildContext context) {
    return Container(
      child: Container(
        width: 100,
        height: 60,
        child: Center(
          child: Text("on Click screen 2 :...").setOnClick(() {
            widget.onCLick!();
          }),
        ),
        color: Colors.red,
      ),
      height: 200,
      width: double.infinity,
    );
  }
}
