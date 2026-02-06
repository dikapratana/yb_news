import 'package:flutter/material.dart';

class AppShadowStyles {
  static const soft = [
    BoxShadow(color: Color(0x14000000), blurRadius: 3, offset: Offset(2, 2)),
  ];

  static const softTop = [
    BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(-2, -2)),
  ];

  static const medium = [
    BoxShadow(color: Color(0x1F000000), blurRadius: 12, offset: Offset(0, 6)),
  ];

  static const strong = [
    BoxShadow(color: Color(0x29000000), blurRadius: 20, offset: Offset(0, 10)),
  ];

  static const none = <BoxShadow>[];
}
