import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/data/MusicDatabase.dart';
import 'package:flutter_app/example/music/MusicModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

import 'BrowseScreen.dart';
//main(MusicModel musicModel) => runApp(MaterialApp(home: PlaylistsScreen(musicModel)));

class PlaylistsScreen extends StatelessWidget {
  MusicModel musicModel = null;

  PlaylistsScreen({Key key, musicModel}) : super(key: key) {
    this.musicModel = musicModel;
  }

  //({Key key,MusicModel musicModel}) : super(Key: key);
  build(BuildContext context) {
    musicModel.url.toString().Logs("musicModel :...");
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: RefreshIndicator(
            onRefresh: () async {
              print('onRefresh called');
            },
            child: PageView(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                Center(
                  child: NowScreen(), //Text('hello'),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar());
  }
}

class _Button extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  _Button({Key key, this.icon, this.onPressed, this.size}) : super(key: key);

  build(BuildContext context) {
    return InkWell(
      child: Icon(
        icon,
        size: size,
      ),
      onTap: onPressed,
    );
  }
}

class NowScreen extends StatefulWidget {
  createState() => _NowScreen();
}

class _NowScreen extends State<NowScreen> {
  var isRenew = true;
  var isRandom = true;

  //var advancedPlayer = AudioPlayer();
  _playAudio() {}

  build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Wrap(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: InkWell(
                        child: Icon(
                          Icons.chevron_left,
                          size: 38,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      color: Colors.transparent,
                    ),
                    Expanded(
                      child: Container(
                        child: GestureDetector(
                          child: Text(
                            "Playlists",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          onTap: () {
                            "print :...Playlists".Log();
                          },
                        ),
                        color: Colors.transparent,
                        margin: EdgeInsets.only(left: 25),
                      ),
                    ),
                    Container(
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.black12,
                        radius: 20,
                      ),
                      color: Colors.transparent,
                      //margin: EdgeInsets.only(right: 15),
                    )
                  ],
                ),
                Container(
                  child: InkWell(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(150.0),
                        child: Image.network(
                          "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                          height: 250,
                          width: 250,
                        )),
                    onTap: () {
                      "onTap :...".Log();
                      print("onTap :...");
                    },
                  ),
                  margin: EdgeInsets.only(top: 45),
                ),
                Container(
                  child: Text(
                    "Now Playing",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  margin: EdgeInsets.only(top: 15),
                ),
                Container(
                  child: Text(
                    "Inis Mona - Eluveitie",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  margin: EdgeInsets.only(top: 5),
                ),
                Container(
                  child: InkWell(
                    child: Text(
                      "Eluveitie",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                    onTap: () {
                      "Eluveitie :...".Log();
                    },
                  ),
                  margin: EdgeInsets.only(top: 25),
                ),
                Container(
                  // Todo : add image svg ...
                  child: SvgPicture.asset("assets/image/seek_bar.svg",
                      color: Colors.red, semanticsLabel: 'A red up arrow'),
                  // Todo : add image png ...
                  // child: Image(
                  //   image: AssetImage("assets/image/seek_bar.png"),
                  // ),
                  color: Colors.transparent,
                  margin: EdgeInsets.only(top: 20),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "03:36",
                          style: TextStyle(fontSize: 12, color: Colors.black26),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "01:22",
                          style: TextStyle(fontSize: 12, color: Colors.black26),
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 35, right: 35, top: 10),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: IconButton(
                        icon: Icon(
                          Icons.autorenew,
                          color: isRenew ? Colors.black : Colors.black26,
                        ),
                        onPressed: () {
                          Fluttertoast.showToast(msg: "Fluttertoast :...");
                          print("print :...");

                          "IconButton :...".Log();
                        },
                      )),
                      Expanded(child: Text("")),
                      Container(
                          child: IconButton(
                        icon: Icon(
                          Icons.add_road_sharp,
                          color: isRenew ? Colors.black : Colors.black26,
                        ),
                        onPressed: () {
                          print("print :...");
                          setState(() {
                            isRandom = false;
                          });
                        },
                      )),
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: LinearPercentIndicator(
                            animation: true,
                            lineHeight: 15.0,
                            animationDuration: 2000,
                            percent: 0.9,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.red,
                          ),
                        ),
                        color: Colors.transparent,
                      )),
                      Container(
                          child: Container(
                        child: Row(
                          children: [
                            _Button(
                              // Icons.skip_previous_sharp,
                              // size: 40,
                              icon: Icons.skip_previous_sharp,
                              size: 40,
                              onPressed: () {
                                "onPressed :... next :...".Log();
                              },
                            ),
                            InkWell(
                              child: Container(
                                child: Center(
                                    child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                )),
                                margin: EdgeInsets.only(left: 10, right: 10),
                              ),
                              onTap: () {
                                //Todo : "play :... ".Log();
                                _playAudio();
                              },
                            ),
                            _Button(
                              icon: Icons.skip_next_sharp,
                              size: 40,
                              onPressed: () {
                                "onPressed :...".Log();
                              },
                            ),
                          ],
                        ),
                        color: Colors.transparent,
                      )),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 20),
                )
              ],
            )
          ],
        ),
        margin: EdgeInsets.only(left: 0, right: 20, top: 50),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
