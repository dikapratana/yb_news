import 'package:flutter/material.dart';

extension ColorX on Color {
  /// Set alpha / opacity dengan value 0.0 - 1.0
  Color opacityx(double opacity) {
    assert(opacity >= 0 && opacity <= 1, 'opacity must be 0..1');
    return withAlpha((255 * opacity).round());
  }
}
