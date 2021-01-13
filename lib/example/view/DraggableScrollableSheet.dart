import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

main() => runApp(SheetPage());

class App extends StatelessWidget {
  build(BuildContext context) {
    var main = SheetPage();
    return main;
  }
}

class SheetPage extends StatefulWidget {
  createState() => _SheetPage();
}

class _SheetPage extends State<SheetPage> {
  double currentSize = 0.1;

  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DraggableScrollableSheet'),
        ),
        body: SizedBox.expand(
          child: DraggableScrollableSheet(
            initialChildSize: currentSize,
            minChildSize: 0.1,
            maxChildSize: 1.0,
            builder: (BuildContext context, ScrollController scrollController) {
              // scrollController.addListener(() {
              //   "scrollController.offset :.. ${scrollController.offset}".Log();
              //   if (scrollController.offset >= -2.0) {
              //     currentSize = 600;
              //   }
              // });

              scrollController.addListener(() {
                "scrollController.addListener(() :... ".Log();

              });

              return Container(
                color: Colors.blue[100],
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text('Item $index'));
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
