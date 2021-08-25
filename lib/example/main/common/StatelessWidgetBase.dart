//Todo :
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

class WidgetBase extends StatefulWidget {
  String? title;
  Widget? child;
  Color? background;
  Function()?  onBack;

  WidgetBase({Key key, this.title, this.child, this.background, this.onBack})
      : super(key: key);

  createState() => _statelessWidgetBaseextension();
}

class _statelessWidgetBaseextension extends State<WidgetBase> {

  Widget _singleChildScrollView() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [widget.child],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.chevron_left,
                          size: 30,
                        ).setOnClick(() {
                          // ignore: unnecessary_statements
                          widget.onBack();
                        }),
                        Expanded(
                            child: Center(
                          child: Text(
                              widget.title == null ? "null" : widget.title),
                        )),
                        Icon(Icons.menu),
                      ],
                    ),
                  ),
                  floating: true,
                  pinned: true,
                  snap: true,
//bottom: _tapBar(),
                ),
              ];
            },
//body: _tabBarView(),
            body: _singleChildScrollView(),
//body: _singleTabBarView(),
          ),
        ),
      ),
      color: widget.background,
    );
  }
}
