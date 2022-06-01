import 'dart:async';

import 'package:client_common/navigator/guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PageGuard extends StatefulWidget {
  final List<Guard> guards;
  final Widget? child;
  final Widget Function(BuildContext)? builder;
  final void Function(BuildContext)? onInit;

  PageGuard({required this.guards, this.child, this.builder, this.onInit})
      : assert(child != null || builder != null),
        assert(child == null || builder == null);

  @override
  State<StatefulWidget> createState() {
    return _PageGuardState();
  }
}

class _PageGuardState extends State<PageGuard> {
  late Completer<bool> completer;

  _PageGuardState();
  @override
  void initState() {
    super.initState();
    completer = Completer();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      checkAll(context, (BuildContext context) {
        if (widget.onInit != null) widget.onInit!(this.context);
      });
    });
  }

  void checkAll(BuildContext context, Function(BuildContext) callback) async {
    for (Guard checker in widget.guards) {
      try {
        if (!await checker.isValid(context)) {
          completer.complete(false);
          checker.onInvalid(context);
          return;
        }
      } catch (e) {
        print("Page Checker returned an error : $e");
        completer.complete(false);
        checker.onInvalid(context);
        return;
      }
    }

    callback(context);
    completer.complete(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: completer.future,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          if (widget.builder != null) {
            return widget.builder!(context);
          }
          return widget.child!;
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
