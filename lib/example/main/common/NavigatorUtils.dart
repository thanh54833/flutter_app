import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/component/Home.dart';

extension NavigatorUtils on BuildContext {
  push(WidgetBuilder _builder) => {
        Navigator.of(this).push(MaterialPageRoute(
          builder: (context) => _builder(context),
        ))
      };

  pop() => {Navigator.of(this).pop()};
}
