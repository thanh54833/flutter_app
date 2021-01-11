import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/StatelessWidgetBase.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/main/common/NavigatorUtils.dart';

main() => runApp(Home());

class Home extends StatelessWidget {
  build(BuildContext context) {
    return WidgetBase(
      title: "Home",
      child: StateHome(),
      onBack: () {
        context.pop();
      },
    );
  }
}

class StateHome extends StatefulWidget {
  createState() => _StateHome();
}

class _StateHome extends State<StateHome> {
  build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text("Text :...").setOnClick(() => {"onclick text ".Log()}),
        )
      ],
    );
  }
}

// Utils((contexts){
//       return Text("");
//     });

class Utils {
  Utils(Widget Function(BuildContext) utils);
}
