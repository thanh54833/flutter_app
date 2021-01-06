

import 'package:flutter/material.dart';

class ProgressIndicatorDemo extends StatefulWidget {
  @override
  _ProgressIndicatorDemoState createState() =>
      new _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
          child: LinearProgressIndicator(
            value: animation.value,
          ),
        ));
  }
}



/// 1) Using Widget
//
//  Container(
//           margin: EdgeInsets.symmetric(vertical: 20),
//           width: 300,
//           height: 20,
//           child: ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             child: LinearProgressIndicator(
//               value: 0.7,
//               valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
//               backgroundColor: Color(0xffD6D6D6),
//             ),
//           ),
//         )
// enter image description here
//
/// 2) Using dependency
//
// List of different types indicator https://pub.dev/packages/percent_indicator
//
// Try this template code
//
//         child:  Padding(
//           padding: EdgeInsets.all(15.0),
//           child:  LinearPercentIndicator(
//             width: MediaQuery.of(context).size.width - 50,
//             animation: true,
//             lineHeight: 20.0,
//             animationDuration: 2000,
//             percent: 0.9,
//             linearStrokeCap: LinearStrokeCap.roundAll,
//             progressColor: Colors.greenAccent,
//           ),
//         )