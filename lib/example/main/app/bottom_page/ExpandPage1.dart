import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/data/MusicDatabase.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/music/AudioService.dart';
import 'package:flutter_app/example/view/AnimationDelayList.dart';
import 'package:flutter_app/example/view/HorizontalListView.dart';
import 'package:flutter_app/example/view/VolumeControl.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:ui' as ui;
import '../LocalColor.dart';

// Todo : thanh ddang lamf  : https://stackoverflow.com/questions/50160362/blur-portion-of-background-flutter

class ExpandPage1 extends StatefulWidget {
  var isStartAnimation = false;
  final ScrollController scrollController;
  Function(MusicModel) onClickItem;

  ExpandPage1({this.isStartAnimation, this.scrollController});

  createState() => StateExpandPage1();
}

const ColorFilter greyscale = ColorFilter.matrix(<double>[
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);

Future<PaletteGenerator> _updatePaletteGenerator(memory) async {
  var paletteGenerator = await PaletteGenerator.fromImageProvider(Image.memory(
    new Uint8List.fromList(memory),
    height: 60,
    width: 60,
    fit: BoxFit.cover,
  ).image);
  return paletteGenerator;
}

class StateExpandPage1 extends State<ExpandPage1> {
  ValueNotifier<MusicModel> musicModel = ValueNotifier(MusicModel("", "", ""));
  ValueNotifier<Color> colorBg = ValueNotifier(Colors.transparent);

  initState() {
    super.initState();
    widget.onClickItem = (music) {
      "onClickItem :... ${music}".Log();
      this.musicModel.value = music;
      var memory =
          new Uint8List.fromList(musicModel.value.logoMemory.codeUnits);
      _updatePaletteGenerator(memory).then((PaletteGenerator paletteGenerator) {
        colorBg.value = paletteGenerator.dominantColor.color;
      });
    };
  }

  build(BuildContext context) {
    return Container(
      //height: 400,
      //color: Colors.red,
      decoration: BoxDecoration(
        //Here goes the same radius, u can put into a var or function
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: LocalColor.Primary_20,
            spreadRadius: 0.2,
            blurRadius: 0.2,
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
                      height: 300,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                flex: 15,
                                child: Container(
                                  //color: Colors.blue,
                                  child: Stack(
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: musicModel,
                                        builder: (context, value, child) {
                                          var memory = new Uint8List.fromList(
                                              musicModel
                                                  .value.logoMemory.codeUnits);

                                          return Container(
                                            child: ColorFiltered(
                                              colorFilter: greyscale,
                                              //ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                                              child: memory != null
                                                  ? Image.memory(
                                                      memory,
                                                      fit: BoxFit.fitWidth,
                                                    )
                                                  : Image.asset(
                                                      'assets/image/bg_4.jpg',
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          );
                                        },
                                      ),
                                      ValueListenableBuilder(
                                        valueListenable: colorBg,
                                        builder: (context, value, child) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [Colors.white10, value],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Container(
                                    child: MoreItem(
                                      isStart: widget.isStartAnimation,
                                    ),
                                    //margin: EdgeInsets.only(top: 20, bottom: 10),
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(top: 8, right: 8),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 6,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white60,
                                                    spreadRadius: 1,
                                                    blurRadius: 0.2,
                                                  ),
                                                ],
                                              ),
                                              margin: EdgeInsets.only(left: 5),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child:
                                                        ValueListenableBuilder(
                                                            valueListenable:
                                                                musicModel,
                                                            builder: (context,
                                                                value, child) {
                                                              var memory = new Uint8List
                                                                      .fromList(
                                                                  musicModel
                                                                      .value
                                                                      .logoMemory
                                                                      .codeUnits);

                                                              return Image.memory(
                                                                  memory,
                                                                  height: 180,
                                                                  width: 180,
                                                                  fit: BoxFit
                                                                      .cover);
                                                            }),
                                                  ),
                                                  Container(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .favorite_border_rounded,
                                                            size: 25,
                                                            color:
                                                                LocalColor.Dark,
                                                          ),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 0,
                                                                  right: 0,
                                                                  top: 2,
                                                                  bottom: 0),
                                                          alignment:
                                                              Alignment.center,
                                                          onPressed: () {},
                                                        ),
                                                        width: 35,
                                                        height: 35,
                                                        //alignment: Alignment.center,
                                                      ),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        top: 8, left: 8),
                                                  ),
                                                  Positioned.fill(
                                                      child: Align(
                                                    child: Container(
                                                      child: VolumeControl(),
                                                      margin: EdgeInsets.all(5),
                                                    ),
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                  ))
                                                ],
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              //mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(0.0),
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              "How to build a relation ship",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'GafataRegular',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              "Flume . JPEGMAFIA",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      'GafataRegular',
                                                                  color: Colors
                                                                      .white60),
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 5,
                                                                    top: 5),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          )
                                                        ],
                                                      ),
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                    ),
                                                  ),
                                                  flex: 2,
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: LocalColor
                                                                    .Primary_80,
                                                                spreadRadius: 1,
                                                                blurRadius: 5,
                                                              ),
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              child: Container(
                                                                child:
                                                                    IconButton(
                                                                  icon: Icon(Icons
                                                                      .play_arrow_rounded),
                                                                  color:
                                                                      LocalColor
                                                                          .Dark,
                                                                  iconSize: 60,
                                                                  onPressed:
                                                                      () {},
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                              )),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 15),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: LocalColor
                                                                    .Primary_80,
                                                                spreadRadius: 1,
                                                                blurRadius: 5,
                                                              ),
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              child: Container(
                                                                child:
                                                                    IconButton(
                                                                  icon: Icon(Icons
                                                                      .skip_previous_rounded),
                                                                  color:
                                                                      LocalColor
                                                                          .Dark,
                                                                  iconSize: 35,
                                                                  onPressed:
                                                                      () {},
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                              )),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: LocalColor
                                                                    .Primary_80,
                                                                spreadRadius: 1,
                                                                blurRadius: 5,
                                                              ),
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              child: Container(
                                                                child:
                                                                    IconButton(
                                                                  icon: Icon(Icons
                                                                      .skip_next_rounded),
                                                                  color:
                                                                      LocalColor
                                                                          .Dark,
                                                                  iconSize: 35,
                                                                  onPressed:
                                                                      () {},
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                              )),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                        )
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.transparent,
                                  child: SeekBar(
                                    duration: Duration(milliseconds: 1000),
                                    //mediaState?.mediaItem?.duration ?? Duration.zero,
                                    position: Duration(milliseconds: 100),
                                    //mediaState?.position ?? Duration.zero,
                                    onChangeEnd: (newPosition) {
                                      //AudioService.seekTo(newPosition);
                                    },
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
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
