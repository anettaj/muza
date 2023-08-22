import 'package:flutter/material.dart';

class Sizing {
  final BuildContext context;

  Sizing(this.context);

  double setWidth() {
    double width = MediaQuery.of(context).size.width;
    return width;
  }

  double setHeight() {
    double height = MediaQuery.of(context).size.height;
    return height;
  }
}
