//Todo : document .. https://viblo.asia/p/chinh-phuc-rxdart-flutter-trong-3-not-nhac-not-cuoi-cung-rxdart-khong-dang-so-nhu-ban-nghi-bWrZn0qp5xw

import 'dart:async';

import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:rxdart/rxdart.dart';

main() {
  //Todo : class stream Rxdart ...
  /// - TimerStream
  /// - RangeStream
  /// - RetryStream
  /// - MergeStream
  //_example_merge_stream();
  //_example_time_stream();

  //Todo : class extention ...
  /// - debounceTime
  /// - onErrorResumeNext
  /// - interval
  /// - concatWith
  /// - distinctUnique
  //_example_debounce_stream();
  //_example_on_error_resume_next();
  //_example_interval();
  //_example_distinctUnique();

  //Todo : Subjects ...
  /// - BehaviorSubject
  /// - ReplaySubject
  /// - PublishSubject
  //_example_behavior_subject();
  //_example_replay_subject();
  _example_publish_subject();
}

_example_publish_subject() {
  var streamController = PublishSubject(); //StreamController.broadcast();

  streamController.stream.listen((event) {
    "stream.listen :.. ${event} ".LogP();
  });

  Future.delayed(Duration(seconds: 3), () {
    streamController.stream.listen((event) {
      "stream.listen2 :.. ${event} ".LogP();
    });
  });

  streamController.sink
      .addStream(RangeStream(0, 4).interval(Duration(seconds: 1)));
}

_example_replay_subject() {
  var streamController = ReplaySubject(); //StreamController.broadcast();

  streamController.stream.listen((event) {
    "stream.listen :.. ${event} ".LogP();
  });

  Future.delayed(Duration(seconds: 3), () {
    streamController.stream.listen((event) {
      "stream.listen2 :.. ${event} ".LogP();
    });
  });

  streamController.sink
      .addStream(RangeStream(0, 4).interval(Duration(seconds: 1)));
}

_example_behavior_subject() async {
  var streamController = BehaviorSubject(); //StreamController.broadcast();

  streamController.stream.listen((event) {
    "stream.listen :.. ${event} ".LogP();
  });

  Future.delayed(Duration(seconds: 3), () {
    streamController.stream.listen((event) {
      "stream.listen2 :.. ${event} ".LogP();
    });
  });

  streamController.sink
      .addStream(RangeStream(0, 4).interval(Duration(seconds: 1)));
}

_example_distinctUnique() {
  Stream.fromIterable([1, 2, 3, 1, 2]).distinctUnique().listen((event) {
    "distinctUnique :.. ${event} ".LogP();
  });
}

_example_interval() {
  _getStream() async* {
    yield 1;
    yield 2;
    yield 3;
  }

  _getStream().interval(Duration(seconds: 1)).listen((event) {
    "interval :.. ".LogP();
  });
}

_example_on_error_resume_next() {
  _getStream() async* {
    yield 1;
    yield 2;
    throw Exception("Error :.. !");
    yield 2;
  }

  _recoveryStream() async* {
    yield 3;
    yield 4;
  }

  _getStream().onErrorResumeNext(_recoveryStream()).listen((event) {
    "onErrorResumeNext :.. $event ".LogP();
  });
}

_example_debounce_stream() {
  // stream mô phỏng lúc user đang gõ text vào TextField để search
  Stream<String> demoStream() async* {
    yield 'L'; // gỡ chữ L
    yield 'Le'; // gõ thêm chữ e
    yield 'Lea'; // gõ thêm chữ a
    yield 'Lear'; // gõ thêm chữ r
    yield 'Learn'; // gõ thêm chữ n
    await Future.delayed(Duration(seconds: 2)); // dừng gõ 1 giây
    yield 'Learn R'; // tiếp tục gõ dấu space và chữ R
    yield 'Learn Rx'; // gõ tiếp chữ x
    yield 'Learn RxD'; // gõ tiếp chữ D
    yield 'Learn RxDa'; // gõ tiếp chữ a
    yield 'Learn RxDar'; // gõ tiếp chữ r
    yield 'Learn RxDart'; // gõ tiếp chữ t
  }

  demoStream().debounceTime(Duration(seconds: 1)).listen((event) {
    "demoStream :... ${event} ".LogP();
  });
}

_example_time_stream() {
  TimerStream("value", Duration(seconds: 2)).listen((event) {
    "TimerStream :.. ${event}".LogP();
  });

  RangeStream(1, 6).listen((event) {
    "RangeStream :.. ${event}".LogP();
  });
  Stream<int> _retryStream() async* {
    yield 10;
    yield 11;
    throw Exception("Loi !");
    yield 11;
  }

  RetryStream(() {
    return _retryStream();
  }, 2)
      .listen((event) {
    "RetryStream :... ${event}".LogP();
  });
}

_example_merge_stream() async {
  _delay(second) async {
    await Future.delayed(Duration(seconds: second));
  }

  Stream<int> stream1() async* {
    _delay(1);
    yield 11;
    _delay(4);
    yield 12;
  }

  Stream<int> stream2() async* {
    _delay(1);
    yield 21;
    _delay(1);
    yield 22;
  }

  // stream1().forEach((element) {
  //   "stream1 :... ${element}".LogP();
  // });
  // stream2().forEach((element) {
  //   "stream1 :... ${element}".LogP();
  // });

  var stream3 = MergeStream([stream1(), stream2()]);
  stream3.forEach((element) {
    "stream3 :... ${element} ".LogP();
  });
}
