import 'package:flutter/material.dart';

main() => runApp(Part2());

/// thanh làm bài code lap 2 (https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1#6)
/// Tìm hiểu về ListView and ScrollView (https://api.flutter.dev/flutter/widgets/ListView-class.html)
///

class Part2 extends StatelessWidget {
  var data = ["item view 1", "item view 2", "item view 3"];

  build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App Part 2",
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter App Part 2"),
          ),
          body: Center(
            // child: Text("Center"),
            /// ex : List view   //child: getListView(),
            /// ex : List view build // child: getListViewBuild(),
            /// ex : List view separator //child: getListViewSeparator(),
            child: getCustomScrollView(),
          )),
    );
  }

  Widget getListView() {
    return ListView(
      padding: EdgeInsets.all(8),
      children: <Widget>[
        Container(
          color: Colors.amber[500],
          height: 50,
          child: Center(child: Text("Text Center 1")),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
        ),
        Container(
          color: Colors.amber[500],
          height: 50,
          child: Center(child: Text("Text Center 1")),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
        ),
        Container(
          color: Colors.amber[500],
          height: 50,
          child: Center(
            child: Text("Text Center 3"),
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
        )
      ],
    );
  }

  Widget getListViewBuild() {
    return ListView.builder(
      itemCount: data.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          color: Colors.amber[500],
          margin: EdgeInsets.all(5),
          child: Center(
            child: Text("___ ${data[index]}"),
          ),
        );
      },
    );
  }

  Widget getListViewSeparator() {
    return ListView.separated(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          color: Colors.amber[500],
          child: Center(
            child: Text("separator :.. ${data[index]}"),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget getCustomScrollView() {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            Text("item scroll view : 1"),
            Text("item scroll view : 2"),
            Text("item scroll view : 3")
          ])),
        )
      ],
    );
  }


}
