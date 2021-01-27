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
import 'package:flutter_app/example/view/bass_boost.dart';
import 'package:flutter_visualizers/Visualizers/BarVisualizer.dart';
import 'package:flutter_visualizers/Visualizers/LineBarVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission/permission.dart';
import 'package:rxdart/rxdart.dart';
import 'LocalColor.dart';
import 'Player.dart';
import 'bottom_page/ExpandPage1.dart';
import 'bottom_page/ExpandPage2.dart';
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
    "_onCLickItemFavourite :.. ".Log();
    //"_musicModel :... ${_musicModel.logoMemory} ".Log();
    itemSelect.value = _musicModel;
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
    var expandPage1 = ExpandPage1(
      isStartAnimation: _bsbController.isExpanded,
    );
    var expandPage2 = ExpandPage2(
      isStartAnimation: _bsbController.isExpanded,
    );

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
                "itemSelect :.. ${value.url} ".Log();
                return BottomBar(
                  itemSelect: value,
                );
              },
            ),
            alignment: Alignment.topCenter,
            height: 80,
          ),
          height: isCollapsed ? 80 : 0,
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
            //"expandedBuilder :...  ".Log();
            //Todo : thanh check case expand finish ...
            var list = [
              Wrap(
                children: [
                  Container(
                    color: Colors.transparent,
                    child: expandPage1,
                  ),
                ],
              ),
              // Wrap(children: [
              //   Container(
              //     color: Colors.green,
              //     child: expandPage2,
              //   ),
              // ])
            ]; //[expand, expand];
            var controller = new PageController(initialPage: 0);

            // ValueListenableBuilder(
            // valueListenable: itemSelect,
            // builder: (context, value, child) {
            //
            // });

            itemSelect.addListener(() {

              expandPage1.onClickItem(itemSelect.value);

            });

            return Wrap(
              children: [
                Container(
                  child: PageView(
                    children: list,
                    pageSnapping: true,
                    controller: controller,
                  ),
                  height: 310,
                  color: Colors.transparent,
                ),
              ],
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
  var isPlaySong = false;

  build(BuildContext context) {
    //Todo :.... thnah ...
    // if (!AudioService.connected) {
    //   isPlaySong = true;
    //   AudioService.connect();
    //   AudioService.start(
    //     backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
    //     androidNotificationChannelName: 'Audio Service Demo',
    //     // Enable this if you want the Android service to exit the foreground state on pause.
    //     androidStopForegroundOnPause: true,
    //     androidNotificationColor: 0xFF2196f3,
    //     androidNotificationIcon: 'mipmap/ic_launcher',
    //     androidEnableQueue: true,
    //   );
    // }

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
                        Container(
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
                            ),
                          ),
                          padding: EdgeInsets.only(top: 4, bottom: 4),
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
                                "widget.itemSelect.url :.. ${widget.itemSelect.url} ___ "
                                    .Log();
                                try {
                                  AudioService.playFromMediaId(
                                      widget.itemSelect.url);
                                  AudioService.play();
                                } catch (e) {
                                  "error message :... ${e} ".Log();
                                }
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
                                      //"playing :... ${playing} ".Log();

                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (!playing)
                                            playButton()
                                          else
                                            pauseButton(),
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
          //Todo :....

          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                child: StreamBuilder<MediaState>(
                  stream: _mediaStateStream,
                  builder: (context, snapshot) {
                    final mediaState = snapshot.data;
                    // 0 -> 1
                    //"mediaState?.mediaItem?.duration :.. ${mediaState?.position}"
                    //   .Log();
                    var value = 0.0;
                    if ((mediaState?.mediaItem?.duration != Duration.zero) &&
                        (mediaState?.mediaItem?.duration != null)) {
                      value = (mediaState?.position ?? Duration.zero)
                              .inMilliseconds /
                          (mediaState?.mediaItem?.duration ?? Duration.zero)
                              .inMilliseconds;
                    }

                    return (value != null)
                        ? LinearProgressIndicator(
                            value: value ?? Duration.zero,
                            minHeight: 100,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                LocalColor.Primary),
                            backgroundColor: LocalColor.Primary_20,
                          )
                        : Container();
                  },
                ),
                height: 3,
                //width: 200,
                //padding: EdgeInsets.all(8),
                color: Colors.transparent,
              ),
            ),
            margin: EdgeInsets.only(left: 10, right: 10, top: 4),
          ),
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
        //isPlaySong = true;
        return AudioService.play();
      });

  IconButton pauseButton() => IconButton(
      icon: Icon(
        Icons.pause,
        color: LocalColor.Gray,
      ),
      iconSize: 25.0,
      onPressed: () {
        //isPlaySong = false;
        return AudioService.pause();
      });

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
