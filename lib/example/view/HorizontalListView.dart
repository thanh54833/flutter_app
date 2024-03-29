import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';

main() => runApp(Main());

class Main extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  createState() => _App();
}

class _App extends State<App> {
  build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.only(top: 100),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Headline',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  var isFirst = index == 0;
                  var isLast = index == 15;
                  var marginLeft = isFirst ? 20.0 : 0.0;
                  var marginRight = isLast ? 20.0 : 5.0;
                  return Container(
                    margin: EdgeInsets.only(
                        left: marginLeft,
                        top: 5,
                        bottom: 5,
                        right: marginRight),
                    //padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: LocalColor.Primary_50,
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 200,
                        width: 200,
                        child: Stack(
                          children: [
                            Container(
                              child: Image.asset(
                                "assets/image/bg_5.jpg",
                                fit: BoxFit.fitWidth,
                                height: 200,
                                width: 200,
                              ),
                              color: Colors.black54,
                              margin: EdgeInsets.zero,
                            ),
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    color: Colors.transparent,
                                    child: Text(
                                      "Matio na beshi",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'GafataRegular',
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(
                                        left: 8, top: 5, bottom: 3),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              color: Colors.white,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.play_arrow_rounded,
                                                  size: 30,
                                                ),
                                                padding: EdgeInsets.zero,
                                              ),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(right: 10),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          child: Container(
                                            color: Colors.blue,
                                            height: 45,
                                            child: Wrap(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      color: Colors.transparent,
                                                      child: Wrap(
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .min,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .play_arrow_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 18,
                                                                ),
                                                                Container(
                                                                  color: Colors
                                                                      .white,
                                                                  height: 1,
                                                                  width: 20,
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top:
                                                                      2,
                                                                      bottom:
                                                                      3),
                                                                ),
                                                                Text(
                                                                  "363",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                      10,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                )
                                                              ],
                                                            ),
                                                            color: Colors
                                                                .transparent,
                                                          )
                                                        ],
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          left: 8, right: 5),
                                                    ),
                                                    /////
                                                    Container(
                                                      height: 20,
                                                      width: 1,
                                                      color: Colors.white,
                                                      alignment:
                                                      Alignment.center,
                                                    ),

                                                    Container(
                                                      color: Colors.transparent,
                                                      child: Wrap(
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .min,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .download_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 18,
                                                                ),
                                                                Container(
                                                                  color: Colors
                                                                      .white,
                                                                  height: 1,
                                                                  width: 25,
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top:
                                                                      1,
                                                                      bottom:
                                                                      2),
                                                                ),
                                                                Text(
                                                                  "363",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                      10,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                )
                                                              ],
                                                            ),
                                                            color: Colors
                                                                .transparent,
                                                          )
                                                        ],
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          left: 5, right: 5),
                                                    ),
                                                    /////
                                                    Container(
                                                      height: 20,
                                                      width: 1,
                                                      color: Colors.white,
                                                      alignment:
                                                      Alignment.center,
                                                    ),

                                                    Container(
                                                      color: Colors.transparent,
                                                      child: Wrap(
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .min,
                                                              children: [
                                                                Container(
                                                                  child: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 12,
                                                                  ),
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      3),
                                                                ),
                                                                Container(
                                                                  color: Colors
                                                                      .white,
                                                                  height: 1,
                                                                  width: 25,
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top:
                                                                      2,
                                                                      bottom:
                                                                      3),
                                                                ),
                                                                Text(
                                                                  "363",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                      10,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                )
                                                              ],
                                                            ),
                                                            color: Colors
                                                                .transparent,
                                                            alignment: Alignment
                                                                .center,
                                                          )
                                                        ],
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          left: 5, right: 8),
                                                      alignment:
                                                      Alignment.center,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                        )
                                      ],
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                    ),
                                    color: Colors.transparent,
                                    padding: EdgeInsets.only(bottom: 5),
                                  )
                                ],
                              ),
                              alignment: Alignment.bottomCenter,
                              color: Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Text(
                'Demo Headline 2',
                style: TextStyle(fontSize: 18),
              ),
              alignment: Alignment.centerLeft,
            ),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Container(
                color: Colors.blue,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 20,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          title: Text('Motivation $int'),
                          subtitle:
                          Text('this is a description of the motivation')),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
