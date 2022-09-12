import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class SimplePage extends StatelessWidget {
  final String title;
  final String message;
  final TextAlign textAlign;
  final String? backInkText;
  final void Function()? backInkAction;
  final Widget? child;

  const SimplePage({
    Key? key,
    this.title = "",
    this.message = "",
    this.textAlign = TextAlign.center,
    this.backInkText,
    this.backInkAction,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = LenraTheme.of(context);
    List<Widget> children = [
      Image.asset(
        'assets/images/logo-vertical.png',
        height: 104.0,
      ),
      SizedBox(height: 40.0)
    ];
    if (title.isNotEmpty) {
      children.add(SizedBox(
        width: double.infinity,
        child: Text(
          title,
          style: theme.lenraTextThemeData.headline2,
          textAlign: textAlign,
        ),
      ));
    }
    if (title.isNotEmpty && message.isNotEmpty) {
      children.add(SizedBox(height: 16.0));
    }
    if (message.isNotEmpty) {
      children.add(SizedBox(
        width: double.infinity,
        child: Text(
          message,
          style: theme.lenraTextThemeData.disabledBodyText,
          textAlign: textAlign,
        ),
      ));
    }
    if (child != null) {
      if (title.isNotEmpty || message.isNotEmpty) {
        children.add(SizedBox(height: 32.0));
      }
      children.add(child!);
    }

    var size = MediaQuery.of(context).size;
    var padding = min(min(size.height * 0.08, size.width * 0.1), 80.0);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: _buildBackInk(context, theme)
                  ..add(Center(
                    child: Container(
                      width: 400,
                      child: Column(
                        children: children,
                      ),
                    ),
                  )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackInk(BuildContext context, LenraThemeData theme) {
    var size = MediaQuery.of(context).size;
    var inkSize = 20;
    var separation = min(min(size.height * 0.05, size.width * 0.06), 48.0);
    if (backInkText == null || backInkText!.isEmpty) {
      return [
        SizedBox(
          height: inkSize + separation,
        )
      ];
    }
    var linkTheme = theme.lenraTextThemeData.bodyText.copyWith(color: theme.lenraColorThemeData.primaryBackgroundColor);
    return [
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(bottom: separation),
          child: InkWell(
              onTap: backInkAction,
              hoverColor: Colors.transparent,
              child: LenraFlex(
                spacing: 12.0,
                children: [
                  Icon(
                    Icons.arrow_back_ios_rounded,
                    color: theme.lenraColorThemeData.primaryBackgroundColor,
                    size: 12,
                  ),
                  Text(backInkText!, style: linkTheme),
                ],
              )),
        ),
      )
    ];
  }
}
