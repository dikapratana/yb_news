import 'package:flutter/material.dart';

class AppShadowStyles {
  /// Soft shadow (default card)
  static const soft = [
    BoxShadow(
      color: Color(0x14000000), // hitam 8%
      blurRadius: 3,
      offset: Offset(2, 2),
    ),
  ];

  static const softTop = [
    BoxShadow(
      color: Color(0x14000000), // hitam 8%
      blurRadius: 6,
      offset: Offset(-2, -2),
    ),
  ];

  /// Medium shadow
  static const medium = [
    BoxShadow(
      color: Color(0x1F000000), // hitam 12%
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ];

  /// Strong shadow (modal / bottomsheet)
  static const strong = [
    BoxShadow(
      color: Color(0x29000000), // hitam 16%
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
  ];

  /// No shadow
  static const none = <BoxShadow>[];
}
