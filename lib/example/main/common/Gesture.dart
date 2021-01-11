import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension OnClickListener on Widget {
  Widget setOnClick(onClick()) {
    return InkWell(
      child: this,
      onTap: () {
        onClick();
      },
    );
  }

  Widget setOnLongClick(onClick()) {
    return InkWell(
      child: this,
      onTap: () {
        onClick();
      },
    );
  }
}
