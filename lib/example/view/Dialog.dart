import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/DialogUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(App());

///For All the widget of Flutter you can implement onPressed using these widget
//
// 1. InkWell() : Using this widget you can add ripple effect on clicking
//
// InkWell(
//      onTap: () {
//          Navigator.pushNamed(context, "write your route");
//      },
//      child: new Text("Click Here"),
//  );
//
// 2. GestureDetector() : Using this widget you can implement, onTap, onDoubleTap, onLongPress and many more
//
// GestureDetector(
//      onTap: () {
//          Navigator.pushNamed(context, "write your route");
//      },
//      onLongPress: (){
//         // open dialog OR navigate OR do what you want
//      }
//      child: new Text("Save"),
//  );
///

class App extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Test(),
      ),
    );
  }
}

class Test extends StatelessWidget {
  build(BuildContext context) {


    return Scaffold(
      body: Center(
          child: InkWell(
        child: Text(
          "child :...",
        ),
        // onTap: () {
        //   _showMyDialog();
        //   Fluttertoast.showToast(msg: "on tap :...");
        // },
        onTap: () async {
          await DialogUtils.showMyDialog(context);
        },
        // onTap: () {
        //   DialogUtils.showCustomDialog(context,
        //       title: "Gallary",
        //       okBtnText: "Save",
        //       cancelBtnText: "Cancel",
        //       okBtnFunction: () => {});
        // },
      )),
    );
  }
}
