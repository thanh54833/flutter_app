import 'package:flutter/material.dart';

main() => runApp(TabsPage());

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Tab Example'),
              bottom: TabBar(
                tabs: <Widget>[
                  Text(
                    'Favourites',
                  ),
                  Text('Playlist'),
                  Text(
                    'Tracks',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child: Container(child: Image.network('your image')),
                ),
                Center(
                  child: Container(child: Icon(Icons.youtube_searched_for)),
                ),
                Center(
                  child: Container(child: Text('Text with style')),
                )
              ],
            )),
      ),
    );
  }
}
