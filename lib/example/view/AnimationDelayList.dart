import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
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
                color: Colors.red,
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
  SvgPicture.asset(
    "assets/image/shuffle.svg",
    color: Colors.white,
    height: 20,
    width: 20,
  ),
  Icon(
    Icons.add_box_outlined,
    color: Colors.white,
  ),
  Icon(
    Icons.favorite_border_rounded,
    color: Colors.white,
  ),
  IconButton(
    icon: Icon(
      Icons.line_style,
      color: Colors.white,
    ),
    onPressed: () {},
    padding: EdgeInsets.zero,
    alignment: Alignment.center,
    constraints: BoxConstraints(),
  ),
  SvgPicture.asset(
    "assets/image/repeat.svg",
    color: Colors.white,
    height: 20,
    width: 20,
  ),
  Icon(
    Icons.settings,
    color: Colors.white,
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
                width: 15,
              ),
            ),
            height: 48,
          )
        : Container(
            height: 40,
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: new Container(
            color: LocalColor.Gray,
            child: widget.item,
            width: 48,
            height: 48,
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
          ),
        ),
      ),
      color: Colors.transparent,
    );
  }
}
