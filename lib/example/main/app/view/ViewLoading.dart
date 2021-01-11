

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            child: Container(
              child: Center(
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Lottie.asset(
                              'assets/image/loading_music.json',
                              width: 200,
                              height: 200,
                            ),
                            padding: EdgeInsets.only(bottom: 0),
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}