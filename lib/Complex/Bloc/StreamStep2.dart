import 'dart:async';

import 'package:flutter_app/example/main/common/LogCatUtils.dart';

main() async {
  //_example_handle_error();
  _example_stream_controller();
}

_example() async* {
  Stream<int> testStream() async* {
    yield 10;
    yield 20;
    yield 30;
    yield 40;
    yield 50;
    yield 55;
    yield 60;
  }

  var future = await testStream().elementAt(2);
  "future :.. ${future} ".LogP();

  var future2 = await testStream().firstWhere((element) => element > 40);
  "future2 :.. ${future2} ".LogP();

  var future3 = await testStream().join(" : ");
  "future3 :.. ${future3} ".LogP();

  var sum = 0;
  await for (final value in testStream()) {
    sum += value;
  }
  "future4 :.. $sum ".LogP();

  // Todo : result stream ...
  await testStream().map((event) => event + 2).forEach((element) {
    "map :...$element ".LogP();
  });

  // await testStream().forEach((element) {
  //   "map :...$element ".LogP();
  // });

  await testStream().where((event) => event >= 30).forEach((element) {
    "where :.. $element ".LogP();
  });

  await testStream().takeWhile((element) => (element <= 30)).forEach((element) {
    "takeWhile :.. $element ".LogP();
  });

  await testStream().skipWhile((element) => (element < 70)).forEach((element) {
    "skipWhile :.. $element ".LogP();
  });

  await testStream()
      .distinct((first, second) => (first ~/ 10 == second ~/ 10))
      .forEach((element) {
    "distinct :.. $element ".LogP();
  });
}

_example_handle_error() {
  // Todo :handle error ..
  Stream<int> testStream2() async* {
    yield 10;
    throw Exception("Loi 123 !!");
    yield 20;
  }

  testStream2().handleError(
    print,
    test: (error) {
      return true;
    },
  ).forEach((element) {
    "handleError :... $element ".LogP();
  });
}

_example_stream_controller() {
  //Todo : Stream controller ...
  var streamController = StreamController.broadcast();
  streamController.stream.listen((event) {
    "event :.. ${event} ".LogP();
  });

  streamController.stream.listen((event) {
    "event2 :.. ${event} ".LogP();
  });

  streamController.sink.add(100);
  streamController.sink.add("push event :...");

  Future.delayed(Duration(milliseconds: 1000));
  streamController.close();
}
