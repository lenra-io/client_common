import 'package:flutter/painting.dart';

extension ColorParser on String {
  Color parseColor() {
    String hex = this.replaceFirst('#', '');
    int hexb16 = int.parse('FF$hex', radix: 16);
    return Color(hexb16);
  }
}
