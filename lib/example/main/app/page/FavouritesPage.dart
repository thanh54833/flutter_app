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
  SongModel()
];

class FavouritesPage extends StatelessWidget {
  build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: songs.length,
          itemBuilder: (context, index) {
            var item = songs[index];
            return Container(
              child: Row(
                //direction: Axis.horizontal,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
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
                          style: Themes.TextStyle_Normal,
                        ),
                        Text(
                          item.artist,
                          style: Themes.TextStyle_Small,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 5, right: 5),
                  ),
                  Expanded(
                      child: Wrap(
                    //direction: Axis.vertical,
                    children: [
                      // SvgPicture.asset(
                      //   "assets/image/seek_bar.svg",
                      //   color: LocalColor.Primary,
                      //   width: 10,
                      //   height: 20,
                      // ),
                      Container(
                        child: Icon(Icons.contactless_outlined),
                        alignment: Alignment.centerRight,
                      ),
                      Container(
                        child: Text(item.time, style: Themes.TextStyle_Small),
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  )),
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.more_horiz),
                          onPressed: () {},
                        ),
                        color: Colors.red,
                      ),
                    ),
                    height: 40,
                    width: 40,
                  )
                ],
              ),
              color: Colors.blue,
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(5),
            );
          },
        ),
        //color: Colors.red,
      ),
    );
  }
}
