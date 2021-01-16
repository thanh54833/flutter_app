import 'dart:async';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

Future<String> firstAsync() async {
  await Future<String>.delayed(const Duration(seconds: 1));
  return "First!";
}

Future<String> secondAsync() async {
  await Future<String>.delayed(const Duration(seconds: 2));
  return "Second!";
}

Future<String> thirdAsync() async {
  await Future<String>.delayed(const Duration(seconds: 3));
  return "Third!";
}

Future<String> asyncNumber(number) async {
  await Future<String>.delayed(const Duration(seconds: 1));
  return "Number :... ${number}";
}

Iterable<int> get positiveIntegers sync* {
  int i = 0;
  while (true) yield i++;
}

void main() {
  Future _runAsync() async {
    // var f = await firstAsync();
    // print(f);
    // var s = await secondAsync();
    // print(s);
    // var t = await thirdAsync();
    // print(t);

    // Future
    //     .wait([firstAsync(), secondAsync(), thirdAsyncC()])
    //     .then((List responses) => chooseBestResponse(responses))
    //     .catchError((e) => handleError(e));
    try {
      //List responses =
      //var list= List<int>.generate(2, (index) => index);

      // Iterable<Future<String>> futures = [
      //   asyncNumber(1).then((value) => "asyncNumber(1) :... ${value}".LogP()),
      //   asyncNumber(2).then((value) => "asyncNumber(2) :... ${value}".LogP())
      // ];

      List<Future<String>> futures2 = [
        asyncNumber(1).then((value) => "asyncNumber2 (1) :... ${value}".LogP()),
        asyncNumber(2).then((value) => "asyncNumber2 (2) :... ${value}".LogP())
      ];

      // var ss = positiveIntegers.skip(0).take(10).toList();
      // Iterable<String> ssss;
      // ssss.
      //"ss :... ${ss} ".LogP();

      //Todo : ex 1 .
      // await Future.wait([
      //   firstAsync().then((value) => {"firstAsync :... ${value}".LogP()}),
      //   secondAsync().then((value) => {"secondAsync :... ${value}".LogP()}),
      //   thirdAsync().then((value) => {"thirdAsync :... ${value}".LogP()})
      // ]);

      //Todo : ex 2 .
      //await Future.wait(futures);
      //Todo : ex 3 .
      await Future.wait(futures2);
      //var responses =
      //responses.then(()=>{});
      //responses.then((data)=>{});

    } catch (e) {
      "error :... ${e}".LogP();
    }
    'done'.LogP();
  }

  //_runAsync.then((value) => {});
  _runAsync();
  'done2'.LogP();
}
