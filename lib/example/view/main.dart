


import 'dart:typed_data';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

main(){

  List<int> charCodes = const [97, 98, 99, 100];
  var bb =new String.fromCharCodes(charCodes);
  print(bb);
  var ss =Uint8List.fromList(bb.codeUnits);
  print("ss :.. .${ss} ");

}