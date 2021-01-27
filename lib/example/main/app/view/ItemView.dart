import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';

class ItemView extends StatefulWidget {
  Function onClick;
  Icon icon = Icon(Icons.play_circle_filled_rounded);
  String content = "";
  ItemView({this.icon, this.content, this.onClick});
  createState() => _ItemView();
}

class _ItemView extends State<ItemView> {
  build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      //height: 50,
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  child: widget.icon,
                ),
                Expanded(
                    child: Container(
                  child: Text(
                    widget.content,
                    style: TextStyle(
                        fontFamily: 'GafataRegular',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  margin: EdgeInsets.only(left: 20),
                ))
              ],
            ),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
          ).setOnClick((){
            widget.onClick();
          }),
          Container(
            child: Divider(),
            margin: EdgeInsets.only(left: 5, right: 5),
          )
        ],
      ),
    );
  }
}
