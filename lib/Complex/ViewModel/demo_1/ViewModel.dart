

import 'package:flutter/cupertino.dart';

class ViewModel with ChangeNotifier{
  String value="value";
  Future setValue(String value) async{
    this.value=value;
    notifyListeners();
  }
}