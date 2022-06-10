import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

Widget createBaseTestWidgets(Widget child) {
  return LenraTheme(
    themeData: LenraThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: child,
    ),
  );
}

Widget createAppTestWidgets(Widget child) {
  return createBaseTestWidgets(
    MaterialApp(home: child),
  );
}

Widget createComponentTestWidgets(Widget child) {
  return createBaseTestWidgets(
    MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    ),
  );
}
