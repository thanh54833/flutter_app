import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/FilesUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:id3/id3.dart';

import '../main/common/Utils.dart';
import 'PlaylistsScreen.dart';

/// thanh chưa làm xong bài này ...
/// thanh : Building beautiful UIs with Flutter , https://codelabs.developers.google.com/codelabs/flutter#0
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
        title: "title",
        theme: ThemeData(
          // Add the 3 lines from here...
          primaryColor: Colors.white,
        ),
        home: MainPage());
  }
}

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  createState() => _HomePage();
}

class MainPage extends StatefulWidget {
  createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: HomePage(title: "HomePage"),
          scrollDirection: Axis.vertical,
        ), //HomePage(title: "HomePage"),//
        bottomNavigationBar: BottomBar());
  }
}

class BottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomBar();
  }
}

class _BottomBar extends State<BottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.open_in_browser_sharp,
            color: _selectedIndex != 0 ? HexColor("#707070") : Colors.red[800],
          ),
          label: 'Browse',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.audiotrack,
            color: _selectedIndex != 1 ? HexColor("#707070") : Colors.red[800],
          ),
          label: 'All track',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.playlist_play,
            color: _selectedIndex != 2 ? HexColor("#707070") : Colors.red[800],
          ),
          label: 'Playlists',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: _selectedIndex != 3 ? HexColor("#707070") : Colors.red[800],
          ),
          label: 'Search',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.red[800],
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}

class _HomePage extends State<HomePage> {
  final void Function(String) onTextChange;

  _HomePage({this.onTextChange});

  String normalizeString(String s) {
    var encoded = ascii.encode(s.toString());
    List<int> normalized = new List.from(encoded.map((e) => (e < 32) ? 32 : e));
    return ascii.decode(normalized);
  }

  _musicData() async {
    List<MusicModel> musics = [];
    List<File> data = await FileUtils.internal().filterFiles(["mp3"]);
    data.asMap().forEach((index, element) {
      var music = MusicModel("url", "name", "description");
      var path = element.absolute.path;

      var mp3instance = new MP3Instance(path);

      if (mp3instance.parseTagsSync()) {
        //var infoFile = mp3instance.getMetaTags();

        //var normal =normalizeString(mp3instance.getMetaTags().toString());

        var title = mp3instance.metaTags["Title"];
        var artist = mp3instance.metaTags["Artist"];
        var album = mp3instance.metaTags["Album"];
        var apic = mp3instance.metaTags["APIC"];

//print("normal :.. ${normal}");

        music.url = "";
        music.name = "";
        music.description = "";

        music.title = title;
        music.artist = artist;
        music.album = album;
      }

      musics.add(music);
    });
    return musics;
  }

  List<MusicModel> musicData = [
    MusicModel(
        "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
        "November Rain",
        "Guns n Roses"),
    MusicModel(
        "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
        "Chop Suey",
        "System of a down"),
    MusicModel(
        "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
        "The Troopers",
        "Iron Maiden")
  ];

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  build(BuildContext context) {
    _musicData().then((data) {
      List<MusicModel> convert = data;
      convert.asMap().forEach((index, element) {

        print("convert :.. ${index} :.. ${element.title}");

      });
      //print("ss.length :... ${convert.length} ");
    });

    //print("data :... ${data.} ");

    return Column(
      children: <Widget>[
        Container(
          child: Wrap(children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Text(
                      "Browse",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    color: Colors.transparent,
                  )),
                  Container(
                    child: CircleAvatar(
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                      radius: 20,
                      backgroundColor: Colors.black12,
                    ),
                    margin: EdgeInsets.only(right: 20),
                  )
                ],
              ),
              margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
              color: Colors.transparent,
            ),
          ]),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(19, 25, 19, 25),
          child: Wrap(
            children: <Widget>[
              TextField(
                onChanged: onTextChange,
                decoration: InputDecoration(
                    fillColor: HexColor("#50D8D8D8"),
                    hoverColor: HexColor("#707070"),
                    focusColor: Colors.black,
                    filled: true,
                    prefixIcon: Icon(Icons.search).build(context),
                    hintText: 'Search in store ...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.zero),
              ),
            ],
          ),
          color: Colors.transparent,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Top of the week",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                ),
              ),
              Text(
                "See all",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.red,
                      fontSize: 16,
                    ),
              )
            ],
          ),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
        ),
        Container(
          child: Divider(height: 0.75, color: HexColor("#80979797")),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        ),
        Container(
          child: ListView.builder(
            itemCount: musicData.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                musicData[index].url,
                                height: 85,
                                width: 85,
                              )),
                          margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, left: 15),
                                child: Text(
                                  musicData[index].name, //"November Rain",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  musicData[index].description,
                                  //"Guns n Roses",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                              padding: EdgeInsets.all(0),
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text("GET"),
                              onPressed: () {
                                // Todo :
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PlaylistsScreen()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0))),
                          padding: EdgeInsets.only(right: 25),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          color: Colors.transparent,
        ),

        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "All time hits",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                ),
              ),
              Text(
                "See all",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.red,
                      fontSize: 16,
                    ),
              )
            ],
          ),
          margin: EdgeInsets.fromLTRB(20, 25, 20, 5),
        ),

        Container(
          child: Divider(height: 0.75, color: HexColor("#80979797")),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        ),

        Container(
          child: ListView.builder(
            itemCount: musicData.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                musicData[index].url,
                                height: 85,
                                width: 85,
                              )),
                          margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, left: 15),
                                child: Text(
                                  musicData[index].name, //"November Rain",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  musicData[index].description,
                                  //"Guns n Roses",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                              padding: EdgeInsets.all(0),
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text("GET"),
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0))),
                          padding: EdgeInsets.only(right: 25),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        Container(
          height: 50,
          margin: EdgeInsets.all(8),
          color: Colors.transparent,
        ),
        //Expanded(child: Container())
      ],
    );
  }
}

class MusicModel {
  String url = "";
  String name = "";

  String title = "";
  String artist = "";
  String album = "";
  String mime = "";
  String textEncoding = "";
  String picType = "";
  String description = "";
  String base64 = "";

  MusicModel(this.url, this.name, this.description);
}
