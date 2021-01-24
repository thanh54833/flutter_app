import 'dart:async';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bottom_sheet_bar/bottom_sheet_bar.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/Themes.dart';
import 'package:flutter_app/example/main/app/config/AppConfig.dart';
import 'package:flutter_app/example/main/app/page/AlbumsPage.dart';
import 'package:flutter_app/example/main/app/page/FavouritesPage.dart';
import 'package:flutter_app/example/main/app/page/PlaylistPage.dart';
import 'package:flutter_app/example/main/app/page/TracksPage.dart';
import 'package:flutter_app/example/main/app/permission/HandlePermission.dart';
import 'package:flutter_app/example/main/common/DialogCommon.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/main/common/NavigatorUtils.dart';
import 'package:flutter_app/example/music/AudioService.dart';
import 'package:flutter_app/example/view/AnimationDelayList.dart';
import 'package:flutter_app/example/view/ScrollingText.dart';
import 'package:flutter_app/example/view/WaveSlider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission/permission.dart';
import 'package:rxdart/rxdart.dart';
import 'LocalColor.dart';
import 'Player.dart';
import 'data/MusicDatabase.dart';

main() => runApp(Home());

class Home extends StatelessWidget {
  build(BuildContext context) {
    //Todo : Thanh check permission here...
    var handlePermission = HandlePermission.instance;
    handlePermission.requestPermissions([PermissionName.Storage]);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StateHome(),
    );
  }
}

class StateHome extends StatefulWidget {
  createState() => _StateHome();
}

class Listener {
  _showBottomBar() {}
}

class HomeValueNotifier {}

class _StateHome extends State<StateHome> {
  //var isCollapseds2 = ValueNotifier(false);
  ValueNotifier itemSelect = ValueNotifier(MusicModel("", "", ""));

  final myController = TextEditingController();
  final _bsbController = BottomSheetBarController();
  final heightBar = 78;
  var isCollapsed = true;
  var isStartAnimation = false;

  //MusicModel itemSelect;
  var isScan = false;
  var homeValueNotifier = HomeValueNotifier();

  _onCLickItemFavourite(MusicModel _musicModel) {
    //"_musicModel :... ${_musicModel.logoMemory} ".Log();
    itemSelect.value = _musicModel;
    // if ((!isCollapsed) &&
    //     (_musicModel.logoMemory != "") &&
    //     (_musicModel.logoMemory != null)) {
    //   // setState(() {
    //   //   isCollapsed = !isCollapsed;
    //   //   itemSelect = _musicModel;
    //   // });
    //   itemSelect.value = _musicModel;
    // } else {
    //   // setState(() {
    //   //   itemSelect = _musicModel;
    //   // });
    //
    // }
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Container(child: new Text('foo'));
        });
  }

  DialogCommon dialogLoading;

  _showDialogLoading() async {
    dialogLoading = DialogCommon.internal();
    await Future.delayed(Duration(microseconds: 50), () {});
    dialogLoading.showLoading(context);
  }

  initState() {
    super.initState();
    _showDialogLoading();
  }

  build(BuildContext context) {
    var appConfig = AppConfig.instance;
    appConfig.setIndexCurrentPlay(5);

    _printLatestValue() {
      print("Second text field: ${myController.text}");
    }

    Future.delayed(Duration(seconds: 5), () {
      "dialogLoading.dismiss(); :... ".Log();
      if (Navigator.canPop(context)) {
        "dialogLoading.dismiss()111 :... ".Log();
        dialogLoading.dismiss();
      }
    });
    var homeWidget = HomeWidget(
      onCLickItemFavourite: _onCLickItemFavourite,
    );
    myController.addListener(_printLatestValue);
    return Scaffold(
      backgroundColor: LocalColor.Background,
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              Expanded(
                  child: Text(
                "Music Player",
                style: TextStyle(
                    color: LocalColor.Black,
                    fontFamily: 'GafataRegular',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ).setOnClick(() {})),
              IconButton(
                icon: Icon(
                  Icons.add_box_outlined,
                  color: LocalColor.Primary,
                ),
                onPressed: () {
                  var dialog = DialogCommon.internal();
                  dialog.showDialogV2(context, () {
                    //dialog.dismiss();
                    //dialog.showLoading(context);

                    Future.delayed(Duration(microseconds: 50), () {
                      homeWidget.onClickScan();
                    });

                    // Future.wait([
                    //   Future.delayed(Duration(microseconds: 50), () {
                    //     "Future.delayed :... ".Log();
                    //     homeWidget.onClickScan();
                    //   }),
                    //   Future.delayed(Duration(seconds: 5), () {
                    //     "Future.delayed :... ".Log();
                    //     //homeWidget.onClickScan();
                    //     dialog.dismiss();
                    //   }),
                    // ]);
                  });
                },
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(0),
              )
            ],
          ),
          height: 60,
          margin: EdgeInsets.only(top: 15, right: 0),
          color: Colors.transparent,
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BottomSheetBar(
          locked: false,
          color: Colors.transparent,
          backdropColor: Colors.transparent,
          collapsed: Container(
            child: ValueListenableBuilder(
              valueListenable: itemSelect,
              builder: (context, value, child) {
                return BottomBar(
                  itemSelect: value,
                );
              },
            ),
            alignment: Alignment.topCenter,
            height: 85,
          ),
          height: isCollapsed ? 85 : 0,
          controller: _bsbController,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          borderRadiusExpanded: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          expandedBuilder: (scrollController) {
            return Expand(
              isStartAnimation: _bsbController.isExpanded,
            );
          },
          body: Container(
            color: LocalColor.Background,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              new BoxShadow(
                                color: LocalColor.Primary_50,
                                spreadRadius: 1,
                                blurRadius: 5,
                                // You can set this blurRadius as per your requirement
                              ),
                            ]),
                        child: TextField(
                          controller: myController,
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.black26, fontSize: 16),
                            hintText: 'Search name',
                            prefixIcon: Icon(
                              Icons.search_sharp,
                              size: 25,
                              color: LocalColor.Primary,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15),
                          ),
                          style:
                              TextStyle(color: LocalColor.Black, fontSize: 16),
                        ),
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 0, bottom: 3),
                      ),
                      Expanded(
                          child: Container(
                        color: Colors.transparent,
                        child: Stack(
                          children: [homeWidget],
                          alignment: Alignment.bottomCenter,
                        ),
                      )),
                      //Todo :bottom bar ...
                    ],
                  ),
                  color: Colors.transparent,
                )),
              ],
            ),
            margin: EdgeInsets.only(top: 20),
          )),
    );
  }
}

class BottomBar extends StatefulWidget {
  MusicModel itemSelect;

  BottomBar({this.itemSelect});

  createState() => _BottomBar();
}

// NOTE: Your entrypoint MUST be a top-level function.
void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class _BottomBar extends State<BottomBar> {
  build(BuildContext context) {
    AudioService.stop();
    //AudioService.stop();
    //"AudioService.connected 1  ${AudioService.connected} ".Log();

    //Todo : kiêm tra list data :...
    if (false) {
      AudioService.start(
        backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
        androidNotificationChannelName: 'Audio Service Demo',
        // Enable this if you want the Android service to exit the foreground state on pause.
        //androidStopForegroundOnPause: true,
        androidNotificationColor: 0xFF2196f3,
        androidNotificationIcon: 'mipmap/ic_launcher',
        androidEnableQueue: false,
      );
    }
    //"AudioService.connected 2 ${AudioService.connected} ".Log();
    if (widget.itemSelect != null) {
      "AudioService.playFromMediaId :... ${widget.itemSelect.url} ".Log();
      //AudioService.playMediaItem(null);
      //AudioService.playFromMediaId(widget.itemSelect.url);
      //AudioService.play();

      //AudioService.playMediaItem(getMediaItem(widget.itemSelect));
      //AudioService.playFromMediaId(widget.itemSelect.url);

      //AudioService.play();
      //AudioService.play();
      // AudioService.playFromMediaId(widget.itemSelect.url);
      // var stream = AudioService.playbackStateStream
      //     .map((state) => state.playing)
      //     .distinct();
      //
      // // stream.
      // stream.listen((event) {
      //
      // });
      //AudioService.play();
      // StreamBuilder<QueueState>(
      //
      //
      // )
      // final imgStream = StreamController<QueueState>();
      // imgStream.stream.single.then((value) {});
      //AudioService.playFromMediaId(widget.itemSelect.url);

    }
    return AudioServiceWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              //Here goes the same radius, u can put into a var or function
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: LocalColor.Primary_80,
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              child: ((widget.itemSelect != null) &&
                                      (widget.itemSelect.logoMemory != null) &&
                                      (widget.itemSelect.logoMemory != ""))
                                  ? Image.memory(
                                      new Uint8List.fromList(widget
                                          .itemSelect.logoMemory.codeUnits),
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: LocalColor.Primary_20),
                              //margin: EdgeInsets.all(1),
                              //padding: EdgeInsets.only(top: 2, bottom: 2),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Wrap(
                              direction: Axis.vertical,
                              children: [
                                Container(
                                  child: MarqueeWidget(
                                    direction: Axis.horizontal,
                                    child: Text(
                                      ((widget.itemSelect != null) &&
                                              (widget.itemSelect.artist !=
                                                  null))
                                          ? " Song:" +
                                              widget.itemSelect.artist +
                                              " "
                                          : "",
                                      style: Themes.TextStyle_Small_Bold,
                                    ),
                                  ),
                                  height: 20,
                                  width: 120,
                                  color: Colors.transparent,
                                ),
                                Container(
                                  child: MarqueeWidget(
                                    direction: Axis.horizontal,
                                    child: Text(
                                      ((widget.itemSelect != null) &&
                                              (widget.itemSelect.artist !=
                                                  null))
                                          ? " " + widget.itemSelect.artist + " "
                                          : "",
                                      style: Themes.TextStyle_Small,
                                    ),
                                  ),
                                  height: 20,
                                  width: 120,
                                  color: Colors.transparent,
                                ),
                              ],
                            ),
                            //alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            padding: EdgeInsets.only(bottom: 8),
                            color: Colors.transparent,
                          ),
                        ),
                        Container(
                          child: StreamBuilder<bool>(
                            stream: AudioService.runningStream,
                            builder: (context, snapshot) {
                              "snapshot.connectionState :... ${snapshot.connectionState} "
                                  .Log();

                              if (snapshot.connectionState !=
                                  ConnectionState.active) {
                                // Don't show anything until we've ascertained whether or not the
                                // service is running, since we want to show a different UI in
                                // each case.
                                return SizedBox();
                              } else {
                                "widget.itemSelect.url :.. ${widget.itemSelect.url}"
                                    .Log();
                                AudioService.playFromMediaId(
                                    widget.itemSelect.url);
                                AudioService.play();
                              }

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  StreamBuilder<QueueState>(
                                    stream: _queueStateStream,
                                    builder: (context, snapshot) {
                                      final queueState = snapshot.data;
                                      final queue = queueState?.queue ?? [];
                                      final mediaItem = queueState?.mediaItem;
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (queue != null &&
                                              queue.isNotEmpty) ...[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.skip_previous,
                                                    color: LocalColor.Gray,
                                                  ),
                                                  iconSize: 25.0,
                                                  onPressed:
                                                      mediaItem == queue.first
                                                          ? null
                                                          : AudioService
                                                              .skipToPrevious,
                                                ),
                                              ],
                                            )
                                          ] else ...[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.skip_previous,
                                                    color: LocalColor.Gray,
                                                  ),
                                                  iconSize: 25.0,
                                                  //onPressed: mediaItem == queue.first ? null : AudioService.skipToPrevious,
                                                ),
                                              ],
                                            )
                                          ],
                                        ],
                                      );
                                    },
                                  ),
                                  StreamBuilder<bool>(
                                    stream: AudioService.playbackStateStream
                                        .map((state) => state.playing)
                                        .distinct(),
                                    builder: (context, snapshot) {
                                      final playing = snapshot.data ?? false;
                                      "playing :... ${playing} ".Log();
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (playing)
                                            pauseButton()
                                          else
                                            playButton(),
                                        ],
                                      );
                                    },
                                  ),
                                  StreamBuilder<QueueState>(
                                    stream: _queueStateStream,
                                    builder: (context, snapshot) {
                                      final queueState = snapshot.data;
                                      final queue = queueState?.queue ?? [];
                                      final mediaItem = queueState?.mediaItem;
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (queue != null &&
                                              queue.isNotEmpty) ...[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.skip_next,
                                                    color: LocalColor.Gray,
                                                  ),
                                                  iconSize: 25.0,
                                                  onPressed: mediaItem ==
                                                          queue.last
                                                      ? null
                                                      : AudioService.skipToNext,
                                                ),
                                              ],
                                            ),
                                          ] else ...[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.skip_next,
                                                    color: LocalColor.Gray_20,
                                                  ),
                                                  iconSize: 25.0,
                                                ),
                                              ],
                                            ),
                                          ]
                                        ],
                                      );
                                    },
                                  ),
                                  Container(
                                      child: IconButton(
                                    icon: Icon(
                                      Icons.volume_up,
                                      color: LocalColor.Gray,
                                    ),
                                    onPressed: () {},
                                  ))
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                color: Colors.white,
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 6, right: 6),
                alignment: Alignment.topCenter,
              ),
            ),
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 2),
          ),
          Container(
            child: WaveSlider(
              initialBarPosition: 10,
              barWidth: 2.0,
              maxBarHight: 20,
              width: 250,
              barPosition: 10,
            ),
            height: 20,
            color: Colors.transparent,
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }

  /// A stream reporting the combined state of the current media item and its
  /// current position.
  Stream<MediaState> get _mediaStateStream =>
      Rx.combineLatest2<MediaItem, Duration, MediaState>(
          AudioService.currentMediaItemStream,
          AudioService.positionStream,
          (mediaItem, position) => MediaState(mediaItem, position));

  /// A stream reporting the combined state of the current queue and the current
  /// media item within that queue.
  Stream<QueueState> get _queueStateStream =>
      Rx.combineLatest2<List<MediaItem>, MediaItem, QueueState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
          (queue, mediaItem) => QueueState(queue, mediaItem));

  /// A stream reporting the combined state of the current queue and the current
  /// media item within that queue.
  Stream<QueueState> get _selectItemStateStream =>
      Rx.combineLatest2<List<MediaItem>, MediaItem, QueueState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
          (queue, mediaItem) => QueueState(queue, mediaItem));

  RaisedButton audioPlayerButton() => startButton(
        'AudioPlayer',
        () {
          AudioService.start(
            backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
            androidNotificationChannelName: 'Audio Service Demo',
            // Enable this if you want the Android service to exit the foreground state on pause.
            //androidStopForegroundOnPause: true,
            androidNotificationColor: 0xFF2196f3,
            androidNotificationIcon: 'mipmap/ic_launcher',
            androidEnableQueue: true,
          );
        },
      );

  IconButton playButton() => IconButton(
      icon: Icon(
        Icons.play_arrow,
        color: LocalColor.Gray,
      ),
      iconSize: 25.0,
      onPressed: () {
        "playButton :... ".Log();
        return AudioService.play;
      });

  IconButton pauseButton() => IconButton(
        icon: Icon(
          Icons.pause,
          color: LocalColor.Gray,
        ),
        iconSize: 25.0,
        onPressed: AudioService.pause,
      );

  RaisedButton startButton(String label, VoidCallback onPressed) =>
      RaisedButton(
        child: Text(
          label,
        ),
        onPressed: onPressed,
      );

  IconButton stopButton() => IconButton(
        icon: Icon(
          Icons.stop,
          color: LocalColor.Gray,
        ),
        iconSize: 25.0,
        onPressed: AudioService.stop,
      );
}

final List<Tab> tabs = <Tab>[
  Tab(text: "Favourites"),
  Tab(text: "Playlist"),
  Tab(text: "Tracks"),
  Tab(text: "Albums"),
];

class HomeWidget extends StatefulWidget {
  Function(MusicModel) onCLickItemFavourite;
  Function onClickScan;

  HomeWidget({
    @required this.onCLickItemFavourite,
  });

  createState() => _StateHomeWidget();
}

class _StateHomeWidget extends State<HomeWidget> {
  build(BuildContext context) {
    var favouritesPage = FavouritesPage(
      onCLick: widget.onCLickItemFavourite,
    );

    widget.onClickScan = () {
      // setState(() {
      //   "widget.onClickScan :... ".Log();
      //   //widget.isScan = true;
      //   favouritesPage.onClickScan();
      // });
      favouritesPage.onClickScan();
    };

    return Container(
      color: Colors.transparent,
      //width: double.infinity,
      //height: double.infinity,
      child: ContainedTabBarView(
        tabs: tabs,
        views: [favouritesPage, PlaylistPage(), TracksPage(), AlbumsPage()],
        onChange: (index) => {print(index)},
        tabBarProperties: TabBarProperties(
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.white,
            labelColor: LocalColor.Primary,
            background: Container(
              color: LocalColor.Background,
            ),
            labelStyle: TextStyle(
                fontFamily: "GafataRegular",
                fontSize: 15,
                fontWeight: FontWeight.bold),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: LocalColor.Primary, width: 2),
              insets: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            )),
      ),
      margin: EdgeInsets.only(top: 2),
    );
  }
}

class Expand extends StatefulWidget {
  var isStartAnimation = false;
  final ScrollController scrollController;

  Expand({this.isStartAnimation, this.scrollController});

  createState() => _Effect();
}

class _Effect extends State<Expand> {
  build(BuildContext context) {
    return Container(
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
                      child: Row(
                        children: [
                          Container(
                            child: Text("60HZ"),
                            width: 70,
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.5,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                ),
                                margin: EdgeInsets.only(left: 00, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 10, left: 10, right: 0),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text("230HZ"),
                            width: 70,
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.9,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                ),
                                margin: EdgeInsets.only(left: 0, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20, left: 10, right: 0),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text("910HZ"),
                            width: 70,
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.4,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                ),
                                margin: EdgeInsets.only(left: 0, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20, left: 10, right: 0),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text("3600HZ"),
                            width: 70,
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.1,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                ),
                                margin: EdgeInsets.only(left: 0, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20, left: 10, right: 0),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              "14000HZ",
                            ),
                            width: 70,
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 14.0,
                                  percent: 0.5,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.blue,
                                ),
                                margin: EdgeInsets.only(left: 0, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20, left: 10, right: 0),
                    ),
                    Container(
                      child: MoreItem(
                        isStart: widget.isStartAnimation,
                      ),
                      margin: EdgeInsets.only(top: 20, bottom: 10),
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
