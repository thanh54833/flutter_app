import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/Home.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
import 'package:flutter_app/example/main/app/Player.dart';

void main() {
  runApp(ExampleApp());
}

class BottomSheetBarPage extends StatefulWidget {
  final String? title;

  BottomSheetBarPage({Key? key, this.title}) : super(key: key);

  @override
  _BottomSheetBarPageState createState() => _BottomSheetBarPageState();
}

class ExampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomSheetBar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomSheetBarPage(title: 'BottomSheetBar Demo Home Page'),
    );
  }
}

class _BottomSheetBarPageState extends State<BottomSheetBarPage> {
  bool _isLocked = false;
  bool _isExpand = true;

  _setExpand() {
    setState(() {
      _isExpand = false;
    });
  }

  final itemList = List<int>.generate(300, (index) => index * index);
  final _bsbController = BottomSheetBarController();
  double radius = 0.0;

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        appBar: AppBar(
          title: Container(
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "Music Player",
                  style: TextStyle(
                      color: LocalColor.Black,
                      fontFamily: 'GafataRegular',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
                IconButton(
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: LocalColor.Primary,
                  ),
                  onPressed: () {},
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(0),
                )
              ],
            ),
            height: 60,
            margin: EdgeInsets.only(top: 15, right: 0),
            color: Colors.transparent,
          ),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: BottomSheetBar(
          locked: _isLocked,
          color: Colors.red,
          backdropColor: Colors.transparent,
          collapsed: Container(
            child: BottomBar(),
            alignment: Alignment.topCenter,
          ),
          height: 90,
          controller: _bsbController,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          ),
          borderRadiusExpanded: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          //Todo : thanh comment ...
          expandedBuilder: (scrollController) => Container(),
          body: Container(
            color: Colors.blue,
          ),
          //Expand(),
        ),
      );
}
