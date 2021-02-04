import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

class Model extends ChangeNotifier {
  var value = 0;

  onChange(int _value) {
    value = _value;
    notifyListeners();
  }
}

main() => runApp(App());

class App extends StatelessWidget {
  var model = new Model();

  build(BuildContext context) {
    "App extends :... ".Log();

    Future.delayed(Duration(seconds: 2), () {
      model.onChange(100);
    });

    Future.delayed(Duration(seconds: 5), () {
      model.onChange(200);
    });

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: ChangeNotifierProvider(
            child: Consumer<Model>(
              builder: (context, value, child) {
                Model _value = value;
                "on change value :.. ${_value.value}".Log();
                return Container();
              },
            ),
            create: (context) {
              return model;
            },
          ),
        ),
      ),
    );
  }
}
