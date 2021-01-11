import 'package:flutter/cupertino.dart';
import 'package:flutter_app/example/main/common/StatelessWidgetBase.dart';
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
    return Container();
  }
}
