import 'dart:io';
import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/example/main/app/Themes.dart';
import 'package:flutter_app/example/main/app/data/DatabaseUtils.dart';
import 'package:flutter_app/example/main/app/model/SongModel.dart';
import 'package:flutter_app/example/main/app/page/AlbumsPage.dart';
import 'package:flutter_app/example/main/app/page/FavouritesPage.dart';
import 'package:flutter_app/example/main/app/page/PlaylistPage.dart';
import 'package:flutter_app/example/main/app/page/TracksPage.dart';
import 'package:flutter_app/example/main/app/permission/HandlePermission.dart';
import 'package:flutter_app/example/main/common/DialogCommon.dart';
import 'package:flutter_app/example/main/common/DialogUtils.dart';
import 'package:flutter_app/example/main/common/FilesUtils.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/main/common/NavigatorUtils.dart';
import 'package:flutter_app/example/music/MusicModel.dart';
import 'package:flutter_app/example/view/AnimationDelayList.dart';
import 'package:id3/id3.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_metadata_plugin/media_metadata_plugin.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission/permission.dart';

import 'LocalColor.dart';
import 'Player.dart';
import 'data/MusicDatabase.dart';

main() => runApp(Home());

class Home extends StatelessWidget {
  build(BuildContext context) {
    //Todo : Thanh check permission here...
    var handlePermission = HandlePermission.instance;
    handlePermission.requestPermissions([PermissionName.Storage]);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StateHome(),
    );
  }
}

class StateHome extends StatefulWidget {
  createState() => _StateHome();
}

class Listener {
  _showBottomBar() {}
}

class _StateHome extends State<StateHome> {
  final myController = TextEditingController();
  final _bsbController = BottomSheetBarController();
  final heightBar = 78;
  var isCollapsed = false;
  var isStartAnimation = false;
  var isScan = false;

  setIsCollapsed(bool isCollapsed) {
    setState(() {
      this.isCollapsed = isCollapsed;
    });
  }

  _onCLickItemFavourite(MusicModel) {
    //"songModel:..".Log();
    isCollapsed = !isCollapsed;
    setIsCollapsed(isCollapsed);
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Container(child: new Text('foo'));
        });
  }

  DialogCommon dialogLoading;

  _showDialogLoading() async {
    dialogLoading = DialogCommon.internal();
    await Future.delayed(Duration(microseconds: 50), () {});
    dialogLoading.showLoading(context);
  }

  initState() {
    super.initState();
    _showDialogLoading();
  }

  build(BuildContext context) {
    _printLatestValue() {
      print("Second text field: ${myController.text}");
    }

    Future.delayed(Duration(seconds: 5), () {
      "dialogLoading.dismiss(); :... ".Log();
      if (Navigator.canPop(context)) {
        "dialogLoading.dismiss()111 :... ".Log();
        dialogLoading.dismiss();
      }
    });

    var homeWidget = HomeWidget(
      onCLickItemFavourite: _onCLickItemFavourite,
    );

    myController.addListener(_printLatestValue);
    return Scaffold(
      backgroundColor: LocalColor.Background,
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
              ).setOnClick(() {
                isCollapsed = !isCollapsed;
                setIsCollapsed(isCollapsed);
              })),
              IconButton(
                icon: Icon(
                  Icons.add_box_outlined,
                  color: LocalColor.Primary,
                ),
                onPressed: () {
                  var dialog = DialogCommon.internal();
                  dialog.showDialogV2(context, () {
                    homeWidget.onClickScan();
                  });
                },
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
          locked: false,
          color: Colors.transparent,
          backdropColor: Colors.transparent,
          collapsed: Container(
            child: BottomBar(),
            alignment: Alignment.topCenter,
          ),
          height: isCollapsed ? 78 : 0,
          controller: _bsbController,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          borderRadiusExpanded: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          expandedBuilder: (scrollController) {
            return Expand(
              isStartAnimation: _bsbController.isExpanded,
            );
          },
          body: Container(
            color: LocalColor.Background,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              new BoxShadow(
                                color: LocalColor.Primary_50,
                                spreadRadius: 1,
                                blurRadius: 5,
                                // You can set this blurRadius as per your requirement
                              ),
                            ]),
                        child: TextField(
                          controller: myController,
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.black26, fontSize: 16),
                            hintText: 'Search name',
                            prefixIcon: Icon(
                              Icons.search_sharp,
                              size: 25,
                              color: LocalColor.Primary,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15),
                          ),
                          style:
                              TextStyle(color: LocalColor.Black, fontSize: 16),
                        ),
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 0, bottom: 3),
                      ),
                      Expanded(
                          child: Container(
                        color: Colors.transparent,
                        child: Stack(
                          children: [homeWidget],
                          alignment: Alignment.bottomCenter,
                        ),
                      )),
                      //Todo :bottom bar ...
                    ],
                  ),
                  color: Colors.transparent,
                )),
              ],
            ),
            margin: EdgeInsets.only(top: 20),
          )),
    );
  }
}

class BottomBar extends StatefulWidget {
  createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //Here goes the same radius, u can put into a var or function
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: LocalColor.Primary_80,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          child: Row(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "assets/image/bg_2.jpg",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Container(
                      child: Text(
                        "Way down we go",
                        style: Themes.TextStyle_Small_Bold,
                      ),
                    ),
                    Container(
                      child: Text("Kaleo", style: Themes.TextStyle_Small),
                    ),
                    // Container(
                    //   child: Text(""),
                    // )
                  ],
                ),
                //alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 5, right: 5),
                padding: EdgeInsets.only(bottom: 8),
                color: Colors.transparent,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        color: LocalColor.Gray,
                        size: 25,
                      ),
                    )),
                    Expanded(
                        child: IconButton(
                      icon: Icon(
                        Icons.pause,
                        color: LocalColor.Primary,
                        size: 25,
                      ),
                      onPressed: () {
                        context.push((context) => NoonLoopingDemo());
                      },
                    )),
                    Expanded(
                        child: IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        color: LocalColor.Gray,
                        size: 25,
                      ),
                      onPressed: () {},
                    )),
                    Expanded(
                        child: IconButton(
                      icon: Icon(
                        Icons.volume_up,
                        color: LocalColor.Gray,
                      ),
                      onPressed: () {},
                    ))
                  ],
                ),
              )
            ],
          ),
          color: Colors.white,
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 6, right: 6),
          alignment: Alignment.topCenter,
        ),
      ),
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
    );
  }
}

final List<Tab> tabs = <Tab>[
  Tab(text: "Favourites"),
  Tab(text: "Playlist"),
  Tab(text: "Tracks"),
  Tab(text: "Albums"),
];

class HomeWidget extends StatefulWidget {
  Function(MusicModel) onCLickItemFavourite;
  Function onClickScan;

  HomeWidget({
    @required this.onCLickItemFavourite,
  });

  createState() => _StateHomeWidget();
}

class _StateHomeWidget extends State<HomeWidget> {
  build(BuildContext context) {
    var favouritesPage = FavouritesPage(
      onCLick: widget.onCLickItemFavourite,
    );

    widget.onClickScan = () {
      setState(() {
        "widget.onClickScan :... ".Log();
        //widget.isScan = true;
        favouritesPage.onClickScan();
      });
    };

    return Container(
      color: Colors.transparent,
      //width: double.infinity,
      //height: double.infinity,
      child: ContainedTabBarView(
        tabs: tabs,
        views: [favouritesPage, PlaylistPage(), TracksPage(), AlbumsPage()],
        onChange: (index) => {print(index)},
        tabBarProperties: TabBarProperties(
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.white,
            labelColor: LocalColor.Primary,
            background: Container(
              color: LocalColor.Background,
            ),
            labelStyle: TextStyle(
                fontFamily: "GafataRegular",
                fontSize: 15,
                fontWeight: FontWeight.bold),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: LocalColor.Primary, width: 2),
              insets: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            )),
      ),
      margin: EdgeInsets.only(top: 2),
    );
  }
}

class Expand extends StatefulWidget {
  var isStartAnimation = false;
  final ScrollController scrollController;

  Expand({this.isStartAnimation, this.scrollController});

  createState() => _Effect();
}

class _Effect extends State<Expand> {
  build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //Here goes the same radius, u can put into a var or function
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: LocalColor.Primary_50,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Wrap(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 20,
                      ),
                      margin: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text("60HZ"),
                            width: 70,
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.5,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                ),
                                margin: EdgeInsets.only(left: 00, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 10, left: 10, right: 0),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text("230HZ"),
                            width: 70,
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.9,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                ),
                                margin: EdgeInsets.only(left: 0, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20, left: 10, right: 0),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text("910HZ"),
                            width: 70,
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.4,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                ),
                                margin: EdgeInsets.only(left: 0, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20, left: 10, right: 0),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text("3600HZ"),
                            width: 70,
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.1,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                ),
                                margin: EdgeInsets.only(left: 0, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20, left: 10, right: 0),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              "14000HZ",
                            ),
                            width: 70,
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.5,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                ),
                                margin: EdgeInsets.only(left: 0, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20, left: 10, right: 0),
                    ),
                    Container(
                      child: MoreItem(
                        isStart: widget.isStartAnimation,
                      ),
                      margin: EdgeInsets.only(top: 20, bottom: 10),
                    )
                  ],
                ),
                color: Colors.white,
              ),
            ),
            color: Colors.transparent,
            margin: EdgeInsets.all(5.0),
          )
        ],
      ),
    );
  }
}
