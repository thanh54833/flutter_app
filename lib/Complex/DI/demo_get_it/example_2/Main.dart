import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';
import 'package:flutter_app/example/main/common/Gesture.dart';

GetIt locator = GetIt.instance;

class LoginService {
  String loginToken = "my_login_token";
}

class UserService {
  String userName = "filledstacks";
}

void setupLocator() {
  locator.registerSingleton(UserService());
  locator.registerFactory<LoginService>(() => LoginService());
}

main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  build(BuildContext context) {
    var useService = locator<UserService>();
    var loginService = locator<LoginService>();
    //" useService.userName :.. ${useService.userName} ".Log();
    //" loginService.loginToken :.. ${loginService.loginToken} ".Log();l
    useService.userName = "name";
    loginService.loginToken = "token";

    return MaterialApp(
      home: Scaffold(
        body: ChildApp(),
      ),
    );
  }
}

class ChildApp extends StatefulWidget {
  createState() => _ChildApp();
}

class _ChildApp extends State<ChildApp> {
  build(BuildContext context) {
    var useService = locator<UserService>();
    var loginService = locator<LoginService>();

    "_userName :.. ${useService.userName} ".Log();
    "_loginToken :.. ${loginService.loginToken} ".Log();

    return Container(
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.red,
        ).setOnClick(() {
          useService.userName = "thanh";
        }),
      ),
    );
  }
}
