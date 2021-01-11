import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/component/Home.dart';
import 'package:flutter_app/example/main/common/StartScreenUtils.dart';
import 'package:flutter_app/example/main/common/StatelessWidgetBase.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:flutter_app/example/main/common/NavigatorUtils.dart';
import 'package:flutter_app/example/view/BottomSheet.dart';

main() => runApp(Catalog());

class Catalog extends StatelessWidget {
  build(BuildContext context) {
    return WidgetBase(
      title: "Mục lục",
      child: StateCatalog(),
    );
  }
}

class StateCatalog extends StatefulWidget {
  Function(int index, String data) onClick;

  createState() => _StateCatalog();
}

class _StateCatalog extends State<StateCatalog> {
  var _data = [
    CatalogItem(
        CatalogItem._titleItem("Bottom sheet"),
        CatalogItem._bodyItems(
          ["Bottom sheet 1", "Child item 1_2"],
        ),
        true),
    CatalogItem(
        CatalogItem._titleItem("Item 2"),
        CatalogItem._bodyItems(
          ["Child item 2_1", "Child item 2_2"],
        ),
        false),
    CatalogItem(
        CatalogItem._titleItem("Item 3"),
        CatalogItem._bodyItems(
          ["Child item 3_1", "Child item 3_2"],
        ),
        false)
  ];

  build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _data.forEach((element) {
                    element.isExpanded = false;
                  });
                  _data[panelIndex].isExpanded = !_data[panelIndex].isExpanded;
                });
              },
              children: _data.map((CatalogItem item) {
                //_BottomSheet();
                item._setOnClick((index, data) => context.push((context) {
                      Home();
                    }));
                return ExpansionPanel(
                  isExpanded: item.isExpanded,
                  headerBuilder: (BuildContext context, bool isExpanded) =>
                      Container(
                    padding: const EdgeInsets.only(left: 15.0),
                    alignment: Alignment.centerLeft,
                    child: item.title.setOnClick(() {
                      //context.push((context) => Home());
                    }),
                  ),
                  body: item.body,
                );
              }).toList())
        ],
      ),
    );
  }
}

class CatalogItem {
  static Function(int index, String data) onClick;

  CatalogItem(this.title, this.body, this.isExpanded);

  _setOnClick(Function(int index, String data) _onClick) {
    onClick = _onClick;
  }

  static Widget _titleItem(String title) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        child: Text(title),
        color: Colors.transparent,
      ),
    );
  }

  static Widget _bodyItem(String body) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        child: Text(body),
      ),
    );
  }

  static Widget _bodyItems(List<String> body) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: body.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              children: [
                Divider(
                  height: 0.75,
                  color: Colors.black12,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            body[index],
                            style: TextStyle(color: Colors.black),
                          ),
                          margin: EdgeInsets.only(left: 15, right: 15),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.chevron_right),
                    )
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            onClick(index, body[index]);
          },
        );
      },
    );
  }

  Widget title;
  Widget body;
  bool isExpanded;
}
