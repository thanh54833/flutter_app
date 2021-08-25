import 'dart:typed_data';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
import 'package:flutter_app/example/main/app/data/MusicDatabase.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter_app/example/main/common/NavigatorUtils.dart';
import 'data/DatabaseUtils.dart';

main() => runApp(NoonLoopingDemo());

class NoonLoopingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WidgetGradient());
  }
}

class WidgetGradient extends StatefulWidget {
  createState() => _WidgetGradient();
}

class _WidgetGradient extends State<WidgetGradient> {
  var index = ValueNotifier(1);
  double height_70 = 70;
  var color = ValueNotifier(Colors.transparent);

  Color color_gradient = Colors.transparent;
  List<MusicModel> listSongs = [];

  initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    var databaseUtils = DatabaseUtils.instance;
    this.listSongs = await databaseUtils.getListFavourites();
    setState(() {});
  }

  _getListData() {
    var _blurRadius = 10.0;
    //"listSongs :.. ${listSongs.length} ".Log();
    return listSongs
        .map((item) => Card(
              child: Container(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_blurRadius)),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 700,
                            width: 700,
                            child: Container(
                              child: Image.memory(
                                new Uint8List.fromList(
                                    item.logoMemory.codeUnits),
                                fit: BoxFit.cover,
                              ),
                              //margin: EdgeInsets.all(20),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  //stops: [0.1, 0.9]
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 50.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      'Despacito',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      child: Text(
                                    "cover by J.Fla",
                                    style: TextStyle(
                                      color: Colors.white24,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                color: Colors.transparent,
              ),
              color: Colors.transparent,
              elevation: 20,
              shadowColor: Colors.black12,
            ))
        .toList();
  }

  Future<PaletteGenerator> _updatePaletteGenerator(index) async {
    var paletteGenerator =
        await PaletteGenerator.fromImageProvider(Image.memory(
      new Uint8List.fromList(listSongs[index].logoMemory.codeUnits),
      height: 60,
      width: 60,
      fit: BoxFit.cover,
    ).image);
    return paletteGenerator;
  }

  build(BuildContext context) {
    "build :... ${listSongs.length} ".Log();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Container(
          color: Colors.transparent,
          child: Container(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 35,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                Expanded(
                    child: Center(
                        child: Text(
                  "Play now",
                  style: TextStyle(
                      fontFamily: 'GafataRegular',
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ))),
                Icon(
                  Icons.playlist_play_outlined,
                  size: 35,
                )
              ],
            ),
          ),
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 15),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              child: Image.asset(
                "assets/image/bg.jpg",
                fit: BoxFit.fitHeight,
              ),
              height: double.infinity,
            ),
            ValueListenableBuilder(
              valueListenable: index,
              builder: (context1, value1, child1) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Container(
                    child: FutureBuilder<PaletteGenerator>(
                        future: _updatePaletteGenerator(value1),
                        // ignore: missing_return
                        builder: (BuildContext context,
                            AsyncSnapshot<PaletteGenerator> snapshot) {
                          if (!snapshot.hasError &&
                              (snapshot.connectionState ==
                                  ConnectionState.done)) {
                            color_gradient = snapshot.data!.dominantColor.color;
                            getColor(alpha) async {
                              await Future.delayed(Duration(milliseconds: 100),
                                  () {
                                "getColor :.. ".Log();
                                color.value = snapshot.data!.dominantColor.color
                                    .withOpacity(alpha);
                              });
                            }

                            Future.wait([
                              getColor(0.2),
                              getColor(0.5),
                              getColor(0.7),
                              getColor(1)
                            ]);
                          }

                          return ValueListenableBuilder(
                            valueListenable: color,
                            builder: (context, value, child) {
                              return Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [value as Color, Colors.transparent],
                                    begin: Alignment.topCenter, //bottomCenter,
                                    end: Alignment.bottomCenter, //topCenter,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                );
              },
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(top: 100),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 1,
                        autoPlay: false,
                        height: 700,
                        //enlargeStrategy: CenterPageEnlargeStrategy.height
                        onPageChanged: (index, reason) {
                          //"index :.. ${index} ".Log();
                          //_gradient = getGradient(index);
                          //_gradient = WidgetGradient();
                          this.index.value = index;
                        },
                      ),
                      items: _getListData(),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: Container(
                                child: Text(
                                  "00:00",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              //flex: 1,
                            ),
                            Expanded(
                                child: Container(
                              child: SvgPicture.asset(
                                "assets/image/seek_bar.svg",
                                height: 30,
                                fit: BoxFit.fitWidth,
                              ),
                              margin: EdgeInsets.only(left: 15, right: 15),
                              height: 30,
                            )),
                            Container(
                              child: Container(
                                child: Text(
                                  "01:00",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              //flex: 1,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                      ),
                      Container(
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: SvgPicture.asset(
                                  "assets/image/shuffle.svg",
                                  color: Colors.white,
                                  height: 20,
                                  width: 20,
                                ),
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 25),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.skip_previous,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  onPressed: () {},
                                ),
                                height: height_70,
                                alignment: Alignment.center,
                              ),
                            ),
                            Container(
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.pause,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      onPressed: () {},
                                      //alignment: Alignment.center,
                                    ),
                                    height: 60,
                                    width: 60,
                                    color: LocalColor.Primary,
                                    //alignment: Alignment.center,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  onPressed: () {},
                                ),
                                height: height_70,
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: SvgPicture.asset(
                                  "assets/image/repeat.svg",
                                  color: Colors.white,
                                  height: 20,
                                  width: 20,
                                ),
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 25),
                              ),
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_box_outlined,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                onPressed: () {},
                              ),
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 11),
                            ),
                            Expanded(
                                child: IconButton(
                              icon: Icon(
                                Icons.favorite_border_rounded,
                                color: LocalColor.Primary,
                                size: 28,
                              ),
                              onPressed: () {},
                            )),
                            Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.line_style,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                onPressed: () {},
                              ),
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 11),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
