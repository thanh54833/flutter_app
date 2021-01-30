import 'package:flutter/material.dart';
import 'package:flutter_app/Complex/Bloc/demo_remove/remote_bloc.dart';
import 'package:flutter_app/Complex/Bloc/demo_remove/remote_event.dart';
import 'package:flutter_app/Complex/Bloc/demo_remove/remote_state.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';

main() => runApp(App());

class App extends StatelessWidget {
  // tạo đối tượng bloc
  final bloc = RemoteBloc();

  _fun() async {
    // UI lắng nghe state thay đổi để update UI
    bloc.stateController.stream.listen((RemoteState state) {
      print('Âm lượng hiện tại: ${state.volume}');
    });
    // giả sử 1s sau, user click vào tăng âm lượng thêm 5
    await Future.delayed(Duration(seconds: 1));
    bloc.eventController.sink
        .add(IncrementEvent(5)); // từ UI push event đến bloc
    // giả sử 2s sau, user click vào giảm âm lượng đi 10
    await Future.delayed(Duration(seconds: 2));
    bloc.eventController.sink
        .add(DecrementEvent(10)); // từ UI push event đến bloc
    // giả sử 3s sau, user click vào mute luôn
    await Future.delayed(Duration(seconds: 3));
    bloc.eventController.sink.add(MuteEvent()); // từ UI push event đến bloc
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Container(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.red,
                        child: Center(
                            child: Text(
                          "-",
                          style: TextStyle(fontSize: 30),
                        )),
                        height: 100,
                      ).setOnClick(() {
                        "setOnClick :.. ".Log();
                        bloc.eventController.sink.add(IncrementEvent(5));
                      })),
                  Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.green,
                        child: Center(
                          //child: Text("100"),
                          child: StreamBuilder(
                            stream: bloc.stateController.stream,
                            builder: (context, snapshot) {
                              RemoteState volumn = snapshot.data;
                              "volumn :.. ${volumn?.volume ?? 0}".Log();
                              if (volumn == null) {
                                volumn = RemoteState(0);
                              }
                              return Text("${volumn.volume}");
                            },
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.red,
                        child: Center(
                            child: Text("+", style: TextStyle(fontSize: 30))),
                        height: 100,
                      ).setOnClick(() {
                        "setOnClick :.. ".Log();
                        bloc.eventController.sink.add(IncrementEvent(5));
                      })),
                ],
              ),
            ),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
