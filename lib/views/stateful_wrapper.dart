import 'package:flutter/material.dart';

typedef Widget Builder(BuildContext context);

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
/// from https://medium.com/filledstacks/how-to-call-a-function-on-start-in-flutter-stateless-widgets-28d90ab3bf49
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Builder builder;
  const StatefulWrapper({
    required this.onInit,
    required this.builder,
  });
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
