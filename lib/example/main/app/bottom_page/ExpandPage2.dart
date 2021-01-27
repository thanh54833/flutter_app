import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/view/AnimationDelayList.dart';
import 'package:flutter_app/example/view/Equalizer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../LocalColor.dart';

class ExpandPage2 extends StatefulWidget {
  var isStartAnimation = false;
  final ScrollController scrollController;

  ExpandPage2({this.isStartAnimation, this.scrollController});

  createState() => StateExpandPage2();
}

class StateExpandPage2 extends State<ExpandPage2> {
  build(BuildContext context) {
    //"_Effect :.. ${_Effect} ".Log();
    return Container(
      //height: 400,
      //color: Colors.red,
      decoration: BoxDecoration(
        //Here goes the same radius, u can put into a var or function
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: LocalColor.Primary_50,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Wrap(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 20,
                      ),
                      margin: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      color: Colors.white,
                      height: 700,
                      child: EqualizerWidget(),
                    )
                  ],
                ),
                color: Colors.white,
              ),
            ),
            color: Colors.transparent,
            margin: EdgeInsets.all(5.0),
          )
        ],
      ),
    );
  }
}
