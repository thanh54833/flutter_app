import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';

main() => runApp(BottomSheet());

class BottomSheet extends StatelessWidget {
  build(BuildContext context) {
    _modalBottomSheetMenu() {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return new Container(
              height: 350.0,
              color: Colors.blue,
              //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: new Center(
                  child: new Text("This is a modal sheet"),
                ),
              ),
            );
          });
    }

    _modalBottomSheetMenu();

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Text("show bottomsheet :... "),
          ),
        ).setOnClick(() => {

          showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return new Container(
                      height: 350.0,
                      color: Colors.blue,
                      //could change this to Color(0xFF737373),
                      //so you don't have to change MaterialApp canvasColor
                      child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                topRight: const Radius.circular(10.0))),
                        child: new Center(
                          child: new Text("This is a modal sheet"),
                        ),
                      ),
                    );
                  })
            }


            ),
      ),
    );
  }
}
