import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';

class Themes {
  static TextStyle TextStyle_Small = TextStyle(
      color: LocalColor.Black,
      fontSize: 14);
  static TextStyle TextStyle_Small_Bold = TextStyle(
      color: LocalColor.Black,
      fontWeight: FontWeight.bold,
      fontSize: 14);
  static TextStyle TextStyle_Normal = TextStyle(
      color: LocalColor.Black,
      //fontFamily:
      fontSize: 16);
  static TextStyle TextStyle_Normal_Bold = TextStyle(
      color: LocalColor.Black,
      fontWeight: FontWeight.bold,
      fontSize: 16);

  static TextStyle TextStyle_Bold = TextStyle(
      color: LocalColor.Black,
      fontWeight: FontWeight.bold,
      fontSize: 16);
}

// extension TextStyle on dynamic{
//   bold(){}
// }
