import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

main() => runApp(App());

class App extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StateApp(),
      ),
    );
  }
}

class StateApp extends StatefulWidget {
  createState() => _StateApp();
}

class Item {
  String name;
  ValueNotifier<bool> value = ValueNotifier(false);

  Item(this.name);

  Item.setValue(bool _value) {
    this.value.value = _value;
  }
}

var listData = [
  Item("item 1"),
  Item("item 2"),
  Item("item 3"),
  Item("item 4"),
  Item("item 5")
];

class _StateApp extends State<StateApp> {
  ValueNotifier<bool> value = ValueNotifier(false);
  var itemSelected = 0;

  build(BuildContext context) {
    listData[itemSelected].value.value = true;

    return Container(
      child: ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, index) {
          return ValueListenableBuilder(
            valueListenable: listData[index].value,
            builder: (context, value, child) {
              //var item =listData[index];
              return Container(
                child: Center(child: Text("${listData[index].name}")),
                height: 100,
                color: listData[index].value.value ? Colors.red : Colors.grey,
                margin: EdgeInsets.only(top: 5),
              ).setOnClick(() {
                "setOnClick :.. ".Log();

                listData[index].value.value = true;
                listData[itemSelected].value.value = false;
                itemSelected = index;

              });
            },
          );
        },
      ),
    );
  }
}
