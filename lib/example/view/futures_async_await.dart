import 'dart:math';

import 'package:flutter/material.dart';

///https://viblo.asia/p/lap-trinh-bat-dong-bo-trong-dartflutter-voi-futures-async-await-OeVKB8Q0lkW

main() => runApp(App());

class App extends StatelessWidget {
  build(BuildContext context) {
    // Future to run
    Future<bool> myTypedFuture(int id, int duration) async {
      await Future.delayed(Duration(seconds: duration));
      print('Delay complete for Future $id');
      return true;
    }
// Running multiple futures
    Future runMultipleFutures() async {
      // Create list of multiple futures
      var futures = <Future>[];
      for (int i = 0; i < 10; i++) {
        futures.add(myTypedFuture(i, Random(i).nextInt(10)));
      }
      // Waif for all futures to complete
      await Future.wait(futures);
      // We're done with all futures execution
      print('All the futures has completed');
    }
    return MaterialApp(
      home: Scaffold(
        body: Center(

          child: InkWell(
            child: Text("Text"),
            onTap: () async {
              await runMultipleFutures();
            },
          ),
        ),
      ),
    );
  }
}
