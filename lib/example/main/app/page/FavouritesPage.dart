import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
import 'package:flutter_app/example/main/app/Themes.dart';
import 'package:flutter_app/example/main/app/model/SongModel.dart';
import 'package:flutter_svg/flutter_svg.dart';

var songs = [
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel(),
  SongModel()
];

class FavouritesPage extends StatelessWidget {
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocalColor.Transparent,
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: songs.length,
          itemBuilder: (context, index) {
            var item = songs[index];

            var isLastItem = (index == songs.length);

            return Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  child: Row(
                    //direction: Axis.horizontal
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            item.logo,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        //alignment: Alignment.center,
                      ),
                      Container(
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              item.name,
                              style: Themes.TextStyle_Small_Bold,
                            ),
                            Text(
                              item.artist,
                              style: Themes.TextStyle_Small,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 5, right: 5),
                        //padding: EdgeInsets.only(bottom: 8),
                      ),
                      Expanded(
                          child: Container(
                        child: Wrap(
                          children: [
                            Container(
                              child: Icon(
                                Icons.contactless_outlined,
                                size: 22,
                              ),
                              alignment: Alignment.centerRight,
                            ),
                            Container(
                              child: Text(item.time,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black26)),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(top: 5),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(right: 8),
                      )),
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            child: IconButton(
                              icon: Icon(Icons.more_horiz),
                              onPressed: () {},
                              padding: EdgeInsets.all(0),
                            ),
                            color: Colors.white54,
                          ),
                        ),
                        height: 35,
                        width: 35,
                      )
                    ],
                  ),
                  color: LocalColor.Primary_20,
                  padding: EdgeInsets.all(8),
                ),
              ),
              margin:
                  EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
            );
          },
        ),
        padding: EdgeInsets.only(bottom: 0),
      ),
    );
  }
}

class AnimatedListItem extends StatefulWidget {
  final int index;

  AnimatedListItem(this.index, {Key key}) : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;

  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: widget.index * 100), () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 1000),
        padding: _animate
            ? const EdgeInsets.all(4.0)
            : const EdgeInsets.only(top: 10),
        child: Container(
          constraints: BoxConstraints.expand(height: 100),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.index.toString(),
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
