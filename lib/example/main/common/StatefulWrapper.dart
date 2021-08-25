import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/Log.dart';

class StatefulWrapper extends StatefulWidget {
  final Function? onInit;
  final Widget? child;

  const StatefulWrapper({@required this.onInit, @required this.child});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    Log("initState :...");
    if (widget.onInit != null) {
      widget.onInit!();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Log("initState :...");
    return widget.child!;
  }
}
