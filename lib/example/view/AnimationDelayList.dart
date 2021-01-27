import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
import 'package:flutter_app/example/view/AlertDialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

main() => runApp(DelayListItems());

class DelayListItems extends StatefulWidget {
  createState() => new _ExampleState();
}

class _ExampleState extends State<DelayListItems> {
  bool isStartAnimation = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("hello"),
          ),
          // ListView Builder
          body: Container(
              child: Column(
            children: [
              Container(
                height: 200,
                width: 40,
                color: Colors.transparent,
              ).setOnClick(() {
                "setOnClick :...".Log();
                setState(() {
                  isStartAnimation = true;
                });
              }),
              MoreItem(
                isStart: isStartAnimation,
              ),
              Expanded(
                  child: Container(
                color: Colors.transparent,
              ))
            ],
          ))),
    );
  }
}

final listData = [
  Icon(
    Icons.add_circle_outline,
    color: LocalColor.Dark,
    size: 25,
  ),
  SvgPicture.asset(
    "assets/image/shuffle.svg",
    color: LocalColor.Dark,
    height: 20,
    width: 20,
  ),
  SvgPicture.asset(
    "assets/image/repeat.svg",
    color: LocalColor.Dark,
    height: 20,
    width: 20,
  ),
  Icon(
    Icons.settings_rounded,
    color: LocalColor.Dark,
    size: 25,
  ),
];

class MoreItem extends StatefulWidget {
  bool isStart = false;

  MoreItem({this.isStart});

  createState() => _MoreItem();
}

class _MoreItem extends State<MoreItem> with TickerProviderStateMixin {
  AnimationController _animationController;
  double animationDuration = 0.0;
  int totalItems = 5;
  bool isExpand = false;

  @override
  void initState() {
    super.initState();
    final int totalDuration = 2000;
    _animationController = AnimationController(
        vsync: this, duration: new Duration(milliseconds: totalDuration));
    animationDuration = totalDuration / (100 * (totalDuration / totalItems));
    //_animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  build(BuildContext context) {
    _animationController.stop(canceled: false);
    _animationController.forward(from: 0.0);
    isExpand = true;

    return isExpand
        ? Container(
            child: ListView.separated(
              itemCount: listData.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Item(
                  index: index,
                  animationController: _animationController,
                  duration: animationDuration,
                  item: listData[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) => Container(
                width: 10,
              ),
            ),
            height: 40,
            color: Colors.transparent,
          )
        : Container(
            height: 30,
            color: Colors.transparent,
          );
  }
}

class Item extends StatefulWidget {
  final int index;
  final AnimationController animationController;
  final double duration;
  final Widget item;

  //Item({this.index, this.animationController, this.duration, this.item});
  Item({this.index, this.animationController, this.duration, this.item});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  Animation _animation;
  double start;
  double end;

  @override
  void initState() {
    super.initState();
    start = (widget.duration * widget.index).toDouble();
    end = start + widget.duration;
    print("START $start , end $end");
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          start,
          end,
          curve: Curves.easeIn,
        ),
      ),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Opacity(
        opacity: _animation.value,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.white.withOpacity(0.1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 0.5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: new Container(
              color: Colors.white,
              child: widget.item,
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.center,
            ),
          ),
          padding: EdgeInsets.all(2),
        ),
      ),
      color: Colors.transparent,
      height: 40,
      width: 40,
    );
  }
}
