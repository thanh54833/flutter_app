import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
import 'package:flutter_app/example/main/app/view/ViewLoading.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';

class DialogCommon {
  static final DialogCommon singleton = DialogCommon.internal();

  factory DialogCommon() {
    return singleton;
  }

  DialogCommon.internal();
  BuildContext? _buildContext;

  dismiss() {
    Navigator.pop(_buildContext!);
  }

  showMaterialDialog(context) async {
    _buildContext = context;
    await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: new Text("Material Dialog"),
              content: new Text("Hey! I'm Coflutter!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  showLoading(context) async {
    _buildContext = context;
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: LocalColor.Primary_20,
                        spreadRadius: 10,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.white,
                      child: Lottie.asset('assets/image/loading_music.json',
                          height: 100, width: 100),
                    ),
                  ),
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.only(top: 50),
                ),
                Expanded(child: Container())
              ],
            ),
            height: double.infinity,
            color: Colors.transparent,
          ),
          //content: Center(child: Text("Text")),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        );
      },
    );
  }

  showDialogV2(context,onClickAgree()) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 100,
                      child: Center(
                        child: Icon(
                          Icons.warning_amber_rounded,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.red,
                    ),
                    // Expanded(
                    //   child:
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            child: Center(
                                child: Text(
                              "Scanning !",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'GafataRegular',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                "An error has occured while creating an error report.",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'GafataRegular',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            margin:
                                EdgeInsets.only(left: 15, right: 15, top: 10),
                          ),
                          Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Agree",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.white),
                                  ).setOnClick(() {
                                    onClickAgree();
                                    Navigator.pop(context);
                                  }),
                                ),
                                color: Colors.red,
                                width: 100,
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10, right: 10),
                              ),
                            ),
                            margin: EdgeInsets.only(top: 20),
                          )
                        ],
                      ),
                    ),
                    //),
                  ],
                ),
                //height: 400,
                width: double.infinity,
                color: Colors.transparent,
              ),
            ),
            // contentPadding: EdgeInsets.all(5),
            insetPadding: EdgeInsets.all(15),
            backgroundColor: Colors.transparent,
          );
        });
  }
}

//content: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Image.asset('assets/image/icon_dialog.gif'),
//                 SizedBox(height: 10.0),
//                 Container(
//                   alignment: Alignment.center,
//                   height: 45.0,
//                   child: Text(
//                     'Tap on mic to VoicePay',
//                     style: TextStyle(fontSize: 20.0),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 SizedBox(height: 30.0),
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.keyboard),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.mic),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.translate),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ],
//             ),
