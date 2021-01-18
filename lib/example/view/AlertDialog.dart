import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/DialogCommon.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';

main() => runApp(AlertDialogApp());

class AlertDialogApp extends StatelessWidget {
  _showDialog(context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          title: Text(
            'VoicePay',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/image/listening.gif'),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.center,
                height: 45.0,
                child: Text(
                  'Tap on mic to VoicePay',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.keyboard),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.translate),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: StateAlertDialog(),
        ),
      ),
    );
  }
}

class ExDialog extends StatefulWidget {
  createState() => _ExDialog();
}

class _ExDialog extends State<ExDialog> {
  build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Center(
          child: Text(""),
        ),
      ),
    );
  }
}

class StateAlertDialog extends StatefulWidget {
  createState() => _StateAlertDialog();
}

class _StateAlertDialog extends State<StateAlertDialog> {
  build(BuildContext context) {
    var dialog = DialogCommon.internal();

    Future.delayed(Duration(milliseconds: 1000), () {
      dialog.showLoading(context); //showDialogV2(context);
    });

    Future.delayed(Duration(milliseconds: 10000), () {
      dialog.dismiss();
    });

    return Container(
      height: 100,
      width: 100,
      color: Colors.red,
    ).setOnClick(() {
      //DialogCommon.internal().showDialogV2(context);
      //DialogCommon.internal().showLoading(context);
    });
  }
}
