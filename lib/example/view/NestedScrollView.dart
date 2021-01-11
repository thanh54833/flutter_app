//Todo :
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/StatelessWidgetBase.dart';

main() => runApp(_NestedScrollView());

class _NestedScrollView extends StatelessWidget {
  Widget _tabBarView() {
    return TabBarView(
      children: <Widget>[
        Center(
            child: Text(
          'T Tab',
          style: TextStyle(fontSize: 30),
        )),
        Center(
            child: Text(
          'B Tab',
          style: TextStyle(fontSize: 30),
        )),
      ],
    );
  }

  Widget _tapBar() {
    return new TabBar(
      tabs: <Tab>[
        new Tab(text: "T"),
        new Tab(text: "B"),
      ], // <-- total of 2 tabs
    );
  }

  Widget _singleChildScrollView() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            color: Colors.tealAccent,
            height: 400,
          ),
          Container(
            color: Colors.black12,
            height: 400,
          ),
          Container(
            color: Colors.tealAccent,
            height: 400,
          ),
        ],
      ),
    );
  }

  Widget _singleTabBarView() {
    return TabBarView(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.tealAccent,
                height: 400,
              ),
              Container(
                color: Colors.black12,
                height: 400,
              ),
              Container(
                color: Colors.tealAccent,
                height: 400,
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetBase(
      title: "Home",
      child: Column(
        children: [
          Container(
            height: 400,
            color: Colors.black12,
          ),
          Container(
            height: 400,
            color: Colors.teal,
          ),
          Container(
            height: 400,
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
