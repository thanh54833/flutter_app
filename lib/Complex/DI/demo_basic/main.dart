import 'package:flutter/cupertino.dart';
import 'file:///C:/Users/admin/AndroidStudioProjects/flutter_app/lib/Complex/DI/demo_basic/injection.dart';
import 'package:injectable/injectable.dart';

main() async {
  //await configureDependencies();
  runApp(App());
}

class App extends StatelessWidget {
  build(BuildContext context) {}
}

@injectable
class A {
  final B b;

  const A(this.b);
}

@injectable
class B {}
