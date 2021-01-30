//Todo : // https://viblo.asia/p/chinh-phuc-rxdart-flutter-trong-3-not-nhac-not-thu-nhat-stream-va-giai-thich-cac-thuat-ngu-Ljy5Vq6blra

import 'package:flutter_app/example/main/common/LogCatUtils.dart';

Future<int> testFuture() async {
  return 3;
}

main() async {
  //_example1();
  //_example2();
  _example3();
}

_example3() {
  Stream<int> _testStream() async* {
    yield 100;
    await Future.delayed(Duration(milliseconds: 2000));
    yield 200;
    yield* Stream.fromIterable([1, 2, 3]);
    throw Exception("Loi :..  !");
  }

  _testStream().listen((event) {
    "event :.. $event ".LogP();
  });
}

_example1() {
  var stream = Stream.value("emit");
  stream.listen(
    (event) {
      "stream :.. ${event}".LogP();
    },
    onDone: () {
      "onDone :.. ".LogP();
    },
  );
  Stream.error(FormatException('lỗi nè'))
      .listen(print, onError: print, onDone: () => print('Done!'));
  Stream.fromIterable([1, 2, 3])
      .listen(print, onError: print, onDone: () => print('Done!'));
  Stream.fromFuture(testFuture())
      .listen(print, onError: print, onDone: () => print('Done!'));
}

_example2() async {
  var subScription = Stream.periodic(Duration(seconds: 1), (int i) {
    if (i == 5) {
      throw Exception('lỗi');
    }
    if (i % 2 == 0) {
      return '$i là số chẵn';
    } else {
      return '$i là số lẻ';
    }
  }).listen(print, onError: print, onDone: () => print('Done!'));

  await Future.delayed(Duration(milliseconds: 2000), () {
    "subScription.pause() :..".LogP();
    subScription.pause();
  });

  await Future.delayed(Duration(milliseconds: 2000), () {
    "subScription.pause() :..".LogP();
    subScription.resume();
  });

  await Future.delayed(Duration(milliseconds: 2000), () {
    " subScription.cancel() :..".LogP();
    subScription.cancel();
  });
}
