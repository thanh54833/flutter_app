import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';

main() => runApp(App());

class App extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AppState(),
        //body: Animation(),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
class Animation extends StatefulWidget {
  double height = 40;
  double maxHeight = 40;
  double minHeight = 10;
  Widget child = Container(height: 40, width: 10, color: Colors.blue);

  Animation({this.child, this.maxHeight, this.minHeight});

  createState() => _Animation();
}

class _Animation extends State<Animation> {
  var rng = new Random();

  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        widget.height = widget.minHeight;
      });
    });
  }

  build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(seconds: 1),
              height: widget.height,
              child: widget.child,
              onEnd: () {
                setState(() {
                  //"onEnd :.. ${widget.height} __  ${widget.minHeight} ".Log();
                  if (widget.height == widget.maxHeight) {
                    var _minHeight = rng.nextInt(widget.minHeight.toInt());
                    widget.height = _minHeight.toDouble();
                  } else {
                    widget.height = widget.maxHeight;
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class AppState extends StatefulWidget {
  createState() => _AppState();
}

class _AppState extends State<AppState> {
  var barPosition = ValueNotifier(0);
  var maxBar = 200;

  build(BuildContext context) {
    barPosition.value = 0;

    countDownTimer() async {
      //int timerCount;
      List<void>.generate(10, (index) => index).forEach((element) async {
        await Future.delayed(Duration(seconds: 1)).then((_) {
          barPosition.value = (barPosition.value + 10) * 2;
          " barPosition.value :... ${barPosition.value} ".Log();
        });
      });
    }

    countDownTimer();
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.yellow,
      child: Column(
        children: [
          Container(
            height: 22,
            child: ValueListenableBuilder(
              valueListenable: barPosition,
              builder: (BuildContext context, int value, Widget child) {
                return WaveSlider(
                  initialBarPosition: maxBar.toDouble(),
                  barWidth: 5.0,
                  maxBarHight: 20,
                  width: MediaQuery.of(context).size.width,
                  barPosition: value.toDouble(),
                );
              },
            ),
            alignment: Alignment.bottomCenter,
            color: Colors.transparent,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),

      // child: new Visualizer(
      //   builder: (BuildContext context, List<int> wave) {
      //     return new CustomPaint(
      //       painter: new LineVisualizer(
      //         waveData: wave,
      //         height: MediaQuery.of(context).size.height,
      //         width: MediaQuery.of(context).size.width,
      //         color: Colors.blueAccent,
      //       ),
      //       child: new Container(),
      //     );
      //   },
      //   //id: playerID,
      // ),
    );
  }
}

class WaveSlider extends StatefulWidget {
  final double initialBarPosition;
  final double barWidth;
  final int maxBarHight;
  final double width;
  double barPosition;

  WaveSlider({
    this.initialBarPosition = 0.0,
    this.barWidth = 5.0,
    this.maxBarHight = 10,
    this.width = 60.0,
    this.barPosition = 0,
  });

  @override
  State<StatefulWidget> createState() => WaveSliderState();
}

class WaveSliderState extends State<WaveSlider> {
  List<int> bars = [];

  //double barPosition;
  double barWidth;
  int maxBarHight;
  double width;
  int numberOfBars;

  void randomNumberGenerator() {
    Random r = Random();
    for (var i = 0; i < numberOfBars; i++) {
      bars.add(r.nextInt(maxBarHight - 5) + 5); //+ 10);
    }
  }

  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    print("tap down " + x.toString());
    setState(() {
      widget.barPosition = x;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.barPosition = widget.initialBarPosition;
    barWidth = widget.barWidth;
    maxBarHight = widget.maxBarHight.toInt();
    width = widget.width;
    if (bars.isNotEmpty) bars = [];
    numberOfBars = width ~/ barWidth;
    randomNumberGenerator();
  }

  @override
  Widget build(BuildContext context) {
    int barItem = 0;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTapDown: (TapDownDetails details) => _onTapDown(details),
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                widget.barPosition = details.globalPosition.dx;
              });
            },
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: bars.map((int height) {
                  Color color = barItem + 1 < widget.barPosition / barWidth
                      ? LocalColor.Primary
                      : Colors.grey;
                  barItem++;
                  return Row(
                    children: <Widget>[
                      Container(
                        width: .1,
                        height: height.toDouble(),
                        color: Colors.green,
                      ),
                      //Animation(
                      // child:
                      Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(1.0),
                            topRight: const Radius.circular(1.0),
                          ),
                        ),
                        height: height.toDouble(),
                        width: 4.8,
                      ),
                      // maxHeight: 10,//height.toDouble(),
                      // minHeight: 5,
                      //)
                      Container(
                        width: .1,
                        height: height.toDouble(),
                        color: Colors.green,
                      ),
                    ],
                  );
                }).toList(),
              ),
              margin: EdgeInsets.only(bottom: 2),
            ),
          ),
        ),
      ),
    );
  }
}
