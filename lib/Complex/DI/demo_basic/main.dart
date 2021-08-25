import 'package:flutter/cupertino.dart';

import 'package:injectable/injectable.dart';

main() async {
  //await configureDependencies();
  runApp(App());
}

class App extends StatelessWidget {
  build(BuildContext context) async {}
}

@injectable
class A {
  final B b;

  const A(this.b);
}

@injectable
class B {}
