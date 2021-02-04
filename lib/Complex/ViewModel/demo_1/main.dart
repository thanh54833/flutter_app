
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Complex/ViewModel/demo_1/ViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

main(){
  WidgetsFlutterBinding.ensureInitialized();
 runApp(App());
}

class App extends StatelessWidget{
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.red,
          // child:ChangeNotifierProvider(
          //   create: (context) => ViewModel(),
          //   child:Consumer<ViewModel>(
          //     // builder: (context, value, child) {
          //     //   return HomeScreen();
          //     // },
          //     child: HomeScreen(),
          //   ),
          //   // builder:(context, child) {
          //   //   "builder :... ".Log();
          //   //   return  HomeScreen();
          //   // },
          // )

          // child: ChangeNotifierProvider.value(
          //   value: ViewModel(),
          //   builder: (context, child) {
          //     return HomeScreen();
          //   } ,
          // ),

          child: ChangeNotifierProvider(create: (context) => ViewModel(),
            child: HomeScreen(),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget{
  build(BuildContext context) {
     var valueCurrent = context.read<ViewModel>().value;

     "valueCurrent  :...  ${valueCurrent}".Log();
     //context.read<ViewModel>().setValue("new value ...... 11111");
     return WillPopScope(child:
     Center(child:
      Text("value :... $valueCurrent"
     ).setOnClick((){
       "setOnClick : ... ".Log();
       context.read<ViewModel>().setValue("new value ...... 11111");
       //context.watch<ViewModel>().setValue("new value ...... 11111");
       //context.
     }),), onWillPop: () {
       "onWillPop :... ".Log();
     },);
  }
}