import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

main() => runApp(App());

class App extends StatelessWidget {
  build(BuildContext context) {
    var view1 = StateApp1();
    var view2 = StateApp2();

    view2.onCLick = () {
      //view1.count = 111;
      //view1.onClickPlusCount();
      view1.appValueNotifiier.incrementNotifier();
      view1.appValueNotifiier.changeHeight();
    };

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            child: Wrap(
                //children: [view1, view2],
                ),
            color: Colors.green,
            height: 700,
          ),
        ),
      ),
    );
  }
}

class AppValueNotifiier {
  ValueNotifier valueNotifier = ValueNotifier(0);
  ValueNotifier height = ValueNotifier(5.0);

  //SizeChangedLayoutNotifier
  //ChangeNotifier
  //ClipboardStatusNotifier
  //InheritedNotifier

  void incrementNotifier() {
    valueNotifier.value++;
  }

  void changeHeight() {
    height.value = 100.0;
  }
}

class StateApp1 extends StatefulWidget {
  int count = 0;
  Function? onClickPlusCount;
  var appValueNotifiier = AppValueNotifiier();

  createState() => _StateApp1();
}

class _StateApp1 extends State<StateApp1> {
  build(BuildContext context) {
    widget.onClickPlusCount = () {
      setState(() {
        widget.count = widget.count + 1;
      });
    };

    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: widget.appValueNotifiier.valueNotifier,
            builder: (context, value, child) {
              "value :.. ${value.toString()} ".Log();
              return Container(
                child: Text("on Click : ${value.toString()}"),
                height: 50,
                width: double.infinity,
                color: Colors.teal,
                alignment: Alignment.center,
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: widget.appValueNotifiier.height,
            builder: (context, value, child) {
              return Container(
                child: Text("Text"),
                height: 0.0,
                width: double.infinity,
                color: Colors.teal,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
              );
            },
          )
        ],
      ),
    );
  }
}

class StateApp2 extends StatefulWidget {
  Function? onCLick;

  createState() => _StateApp2();
}

class _StateApp2 extends State<StateApp2> {
  build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text("Text"),
            height: 50,
            width: double.infinity,
            color: Colors.teal,
            alignment: Alignment.center,
          ),
          Container(
            child: Text("Text"),
            height: 50,
            width: double.infinity,
            color: Colors.teal,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
          ).setOnClick(() {
            "setOnClick :...".Log();
            widget.onCLick!();
          })
        ],
      ),
    );
  }
}
