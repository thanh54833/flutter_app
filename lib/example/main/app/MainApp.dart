import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/Home.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_app/example/main/common/NavigatorUtils.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';

main() => runApp(MusicLogo());

class MusicLogo extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.teal,
        body: StateMain(),
      ),
    );
  }
}

class StateMain extends StatefulWidget {
  createState() => _StateMain();
}

class _StateMain extends State<StateMain> {
  build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 6000), () {
      context.push((context) => Home());
    });

    return Stack(
      children: [
        Lottie.asset('assets/image/music_bg.json',
            fit: BoxFit.fill, height: double.infinity, width: double.infinity),
        Center(
          child: Container(
            child: Container(
              child: Center(
                  child: Wrap(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Lottie.asset('assets/image/music_logo_v2.json',
                            width: 350, height: 350, fit: BoxFit.cover),
                      ),
                      Container(
                        child: Text(
                          "Music player",
                          style: TextStyle(
                            fontSize: 35,
                            color: LocalColor.Primary,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                        margin: EdgeInsets.only(top: 0),
                      ),
                      Container(
                        height: 150,
                      )
                    ],
                  )
                ],
              )),
            ),
          ),
        )
      ],
    );
  }
}
