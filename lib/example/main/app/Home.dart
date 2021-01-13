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
import 'LocalColor.dart';
import 'Player.dart';

main() => runApp(Home());

class Home extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: StateHome(),
    );
  }
}

class StateHome extends StatefulWidget {
  createState() => _StateHome();
}

class _StateHome extends State<StateHome> {
  final myController = TextEditingController();

  build(BuildContext context) {
    _printLatestValue() {
      print("Second text field: ${myController.text}");
    }

    myController.addListener(_printLatestValue);
    return Scaffold(
      extendBodyBehindAppBar: true,
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
              )
            ],
          ),
          height: 60,
          margin: EdgeInsets.only(top: 15),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                        contentPadding: EdgeInsets.only(top: 15, bottom: 15),
                      ),
                      style: TextStyle(color: LocalColor.Black, fontSize: 16),
                    ),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                  ),
                  //child: HomeWidget()
                  Container(
                    // child: NestedScrollView(
                    //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    //
                    //   },
                    //   body: HomeWidget(),
                    // ),
                    // alignment: Alignment.topCenter,
                    child: HomeWidget(),
                    height: 600,
                    color: Colors.yellow,
                  )
                ],
              ),
              color: Colors.transparent,
            )),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          "assets/image/bg_2.jpg",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
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
                              child:
                                  Text("Kaleo", style: Themes.TextStyle_Small),
                            ),
                            Container(
                              child: Text(""),
                            )
                          ],
                        ),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 5, right: 5),
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
                              icon: IconButton(
                                icon: Icon(
                                  Icons.pause,
                                  color: LocalColor.Primary,
                                  size: 25,
                                ),
                                onPressed: () => {
                                  // ignore: missing_return
                                  context.push((context) {
                                    NoonLoopingDemo();
                                  })
                                },
                              ),
                            )),
                            Expanded(
                                child: IconButton(
                              icon: Icon(
                                Icons.skip_next,
                                color: LocalColor.Gray,
                                size: 25,
                              ),
                            )),
                            Expanded(
                                child: IconButton(
                              icon: Icon(
                                Icons.volume_up,
                                color: LocalColor.Gray,
                              ),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                  //height: 100,
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.only(bottom: 8),
              margin: EdgeInsets.only(left: 8, right: 8, top: 8),
            )
          ],
        ),
        margin: EdgeInsets.only(top: 100),
      ),
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
      margin: EdgeInsets.only(top: 0),
    );
  }
}
