import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';

import '../state_container.dart';


main(){
  "main :... ".LogP();
  runApp(new StateContainer(child : App()));
}
class App extends StatelessWidget{
  build(BuildContext context) {
    final container = StateContainer.of(context);
    //"container first name : ${container?.user?.firstName ?? ""} ".Log();
    return MaterialApp(
      home: Scaffold(body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Center(
                child: Text("value ... ${container?.user?.firstName ?? ""}"),
              ),
              color: Colors.green,
            alignment: Alignment.center,
            ),
            StateApp()
          ],
        ),
      ),),
    );
  }
}
class StateApp extends StatefulWidget{
  createState()=>_StateApp();
}

class _StateApp extends State<StateApp>{
 build(BuildContext context) {
   final container = StateContainer.of(context);
   return Container(
     height: 100,
     width: 100,
     child: Center(
       child: Text("value :.."),
     ),
     color: Colors.red,
   ).setOnClick((){
     "setOnClick :...".Log();
     container.updateUserInfo(
       firstName: "first name",
       lastName: "last name",
       email: "email"
     );
   });
  }
}