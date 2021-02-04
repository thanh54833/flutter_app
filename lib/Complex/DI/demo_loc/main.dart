import 'package:flutter_app/example/main/common/LogCatUtils.dart';

main() {
  "main :...".LogP();
  Truck truck1 = Truck();
  Truck truck2 = Truck()..setDivider = Driver("name1", "start1");
  "truck2 :... ${truck2.driver.name}".LogP();
}

class Driver {
  String name = "";
  String starts = "";

  Driver(this.name, this.starts);
}

class Truck {
  Driver driver;

  Truck() {
    driver = Driver("truck", "truck");
  }

  set setDivider(Driver _driver) {
    driver = _driver;
  }
}
