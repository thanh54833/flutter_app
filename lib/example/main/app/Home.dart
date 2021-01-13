import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/Themes.dart';
import 'package:flutter_app/example/main/app/page/AlbumsPage.dart';
import 'package:flutter_app/example/main/app/page/FavouritesPage.dart';
import 'package:flutter_app/example/main/app/page/PlaylistPage.dart';
import 'package:flutter_app/example/main/app/page/TracksPage.dart';
import 'package:flutter_app/example/main/common/StatelessWidgetBase.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/main/common/NavigatorUtils.dart';
import 'package:flutter_app/example/view/BottomSheetBarPage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'LocalColor.dart';
import 'Player.dart';

main() => runApp(Home());

class Home extends StatelessWidget {
  build(BuildContext context) {
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
  //Listener listener;
  var isCollapsed = false;

  //StateHome({Key key, this.listener}) :super(key: key)

  createState() => _StateHome();
//createState() => _StateHome();
}

class Listener {
  _showBottomBar() {}
}

class _StateHome extends State<StateHome> {
  //with Listener s
  final myController = TextEditingController();
  final _bsbController = BottomSheetBarController();
  final heightBar = 78;

  var isCollapsed = false;

  _showBottomBar() {
    "_showBottomBar :... ".Log();
    this.isCollapsed = true;
  }

  build(BuildContext context) {
    _printLatestValue() {
      print("Second text field: ${myController.text}");
    }

    myController.addListener(_printLatestValue);
    return Scaffold(
      //extendBodyBehindAppBar: true,
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
          expandedBuilder: (scrollController) => Effect(),
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
                                color: Colors.black12,
                                spreadRadius: 0.5,
                                blurRadius: 1.0,
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
                        margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                      ),
                      Expanded(
                          child: Container(
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            HomeWidget(),
                          ],
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
      padding: EdgeInsets.only(bottom: 8),
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 0),
    );
  }
}

final List<Tab> tabs = <Tab>[
  Tab(text: "Favourites"),
  Tab(text: "Playlist"),
  Tab(text: "Tracks"),
  Tab(text: "Albums"),
];

class HomeWidget extends StatelessWidget {
  build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      //width: double.infinity,
      //height: double.infinity,
      child: ContainedTabBarView(
        tabs: tabs,
        views: [FavouritesPage(), PlaylistPage(), TracksPage(), AlbumsPage()],
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

class Effect extends StatefulWidget {
  createState() => _Effect();
}

class _Effect extends State<Effect> {
  build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              child: Column(
                children: [
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
                    margin: EdgeInsets.only(top: 20, left: 10, right: 0),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: 150,
                        height: 40,
                        color: LocalColor.Gray,
                        child: Center(
                            child: Text(
                          "Xong",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'GafataRegular'),
                        )),
                      ),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                  )
                ],
              ),
              color: Colors.white,
            ),
          ),
          color: Colors.transparent,
          padding: EdgeInsets.all(5.0),
        )
      ],
    );
  }
}
