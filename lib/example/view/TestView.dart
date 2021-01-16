import 'dart:io';

import 'package:audiotagger/audiotagger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
import 'package:flutter_app/example/main/app/Log.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

main() => runApp(TestView());

class TestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //body: Example1(),
        //body: Example2(),
        body: Example3(),
      ),
    );
  }
}

class Example3 extends StatefulWidget {
  createState() => _Example3();
}

class _Example3 extends State<Example3> {
  uint8list() async {
    var file = File(
        "/storage/emulated/0/NCT/CanhHoaTonThuong-HoangYenChibi-6198745.mp3");

    return await VideoThumbnail.thumbnailData(
      video: file.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
  }

  var bytes;

  void getArtwork() async {
    //final String filePath = "/storage/emulated/0/file.mp3";
    var filePath =
        "/storage/emulated/0/NCT/CanhHoaTonThuong-HoangYenChibi-6198745.mp3";
    bytes = await Audiotagger().readArtwork(path: filePath);
  }

  initState() {
    super.initState();
    getArtwork();
  }

  build(BuildContext context) {
    //Log(" file.length() :... ${file}");
    Log("bytes :...${bytes}");

    return Container(
      child: Center(
          child: Image.memory(
        bytes,
        height: 100,
        width: 100,
      )),
      color: Colors.red,
    );
  }
}

class Example1 extends StatefulWidget {
  createState() => _Example1();
}

class _Example1 extends State<Example1> {
  build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            //Here goes the same radius, u can put into a var or function
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(250)),
            boxShadow: [
              BoxShadow(
                color: Color(0x54000000),
                spreadRadius: 4,
                blurRadius: 20,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(250)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [Theme.of(context).primaryColor, Color(0xff995DFF)],
                ),
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}

class Example2 extends StatefulWidget {
  createState() => _Example2();
}

class _Example2 extends State<Example2> {
  build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            //Here goes the same radius, u can put into a var or function
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: LocalColor.Primary_50,
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   end: Alignment.bottomCenter,
                //   begin: Alignment.topCenter,
                //   colors: [Theme.of(context).primaryColor, Color(0xff995DFF)],
                // ),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
