import 'package:flutter/widgets.dart';

extension SpaceExtension on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
  SizedBox get s => SizedBox(width: toDouble(), height: toDouble());
}
