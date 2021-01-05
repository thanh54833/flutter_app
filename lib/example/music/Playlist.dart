import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Utils.dart';

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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: HomePage(title: "HomePage"),
          scrollDirection: Axis.vertical,
        ), //HomePage(title: "HomePage"),//
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.open_in_browser_sharp,
                color:
                    _selectedIndex != 0 ? HexColor("#707070") : Colors.red[800],
              ),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.audiotrack,
                color:
                    _selectedIndex != 1 ? HexColor("#707070") : Colors.red[800],
              ),
              label: 'All track',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.playlist_play,
                color:
                    _selectedIndex != 2 ? HexColor("#707070") : Colors.red[800],
              ),
              label: 'Playlists',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color:
                    _selectedIndex != 3 ? HexColor("#707070") : Colors.red[800],
              ),
              label: 'Search',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red[800],
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ));
  }
}

class _HomePage extends State<HomePage> {
  final void Function(String) onTextChange;

  _HomePage({this.onTextChange});

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

  build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Wrap(children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Browse",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black),
                    ),
                    width: MediaQuery.of(context).size.width - 50,
                    padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    color: Colors.transparent,
                  ),
                  Container(
                    child: Icon(
                      Icons.people_outline_sharp,
                      size: 30,
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
              color: Colors.transparent,
            ),
          ]),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
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
          //margin: EdgeInsets.fromLTRB(8, 15, 8, 15),
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
          margin: EdgeInsets.fromLTRB(25, 0, 25, 5),
        ),
        Container(
          child: Divider(height: 0.5, color: HexColor("#979797")),
          margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
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
          margin: EdgeInsets.fromLTRB(25, 25, 25, 5),
        ),

        Container(
          child: Divider(height: 0.5, color: HexColor("#979797")),
          margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
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
  String url;
  String name;
  String description;

  MusicModel(this.url, this.name, this.description);
}
