import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Utils.dart';

/// thanh chưa làm xong bài này ...
///thanh : Building beautiful UIs with Flutter , https://codelabs.developers.google.com/codelabs/flutter#0
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
        body: HomePage(title: "HomePage"),
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
          padding: EdgeInsets.fromLTRB(15, 25, 15, 30),
          child: Wrap(
            children: <Widget>[
              TextField(
                  onChanged: onTextChange,
                  decoration: InputDecoration(
                      fillColor: HexColor("#D7D7D7"),
                      hoverColor: HexColor("#707070"),
                      focusColor: Colors.black,
                      filled: true,
                      prefixIcon: Icon(Icons.search).build(context),
                      hintText: 'Search in store ...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.zero)),
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
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                      height: 85,
                      width: 85,
                    ),
                    margin: EdgeInsets.fromLTRB(25, 16, 0, 0),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 8, bottom: 8, left: 15),
                          child: Text(
                            "November Rain",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Guns n Roses",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 15),
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
                            borderRadius: new BorderRadius.circular(30.0))),
                    padding: EdgeInsets.only(right: 25),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                      height: 85,
                      width: 85,
                    ),
                    margin: EdgeInsets.fromLTRB(25, 16, 0, 0),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 8, bottom: 8, left: 15),
                          child: Text(
                            "November Rain",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Guns n Roses",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 15),
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
                            borderRadius: new BorderRadius.circular(30.0))),
                    padding: EdgeInsets.only(right: 25),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                      height: 85,
                      width: 85,
                    ),
                    margin: EdgeInsets.fromLTRB(25, 16, 0, 0),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 8, bottom: 8, left: 15),
                          child: Text(
                            "November Rain",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Guns n Roses",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 15),
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
                            borderRadius: new BorderRadius.circular(30.0))),
                    padding: EdgeInsets.only(right: 25),
                  ),
                ],
              )
            ],
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
        Column(
          children: [
            Row(
              children: <Widget>[
                Container(
                  child: Image.network(
                    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                    height: 85,
                    width: 85,
                  ),
                  margin: EdgeInsets.fromLTRB(25, 16, 0, 0),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 15),
                        child: Text(
                          "November Rain",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Guns n Roses",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
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
                          borderRadius: new BorderRadius.circular(30.0))),
                  padding: EdgeInsets.only(right: 25),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Image.network(
                    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                    height: 85,
                    width: 85,
                  ),
                  margin: EdgeInsets.fromLTRB(25, 16, 0, 0),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 15),
                        child: Text(
                          "November Rain",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Guns n Roses",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
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
                          borderRadius: new BorderRadius.circular(30.0))),
                  padding: EdgeInsets.only(right: 25),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Image.network(
                    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                    height: 85,
                    width: 85,
                  ),
                  margin: EdgeInsets.fromLTRB(25, 16, 0, 0),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 15),
                        child: Text(
                          "November Rain",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Guns n Roses",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
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
                          borderRadius: new BorderRadius.circular(30.0))),
                  padding: EdgeInsets.only(right: 25),
                ),
              ],
            )
          ],
        ),
        Container(
          height: 20,
          margin: EdgeInsets.all(8),
          color: Colors.blue,
        ),
        Expanded(child: Container())
      ],
    );
  }
}
