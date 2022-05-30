import 'package:flutter/material.dart';
import 'package:lenra_components/lenra_components.dart';

class LoadingButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool loading;
  final Widget? rightIcon;

  LoadingButton({
    this.onPressed,
    required this.text,
    this.rightIcon,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    // if (this.loading) {
    //   return CircularProgressIndicator();
    // }

    return LenraButton(
      onPressed: !this.loading ? this.onPressed : null,
      disabled: this.loading ? true : false,
      text: this.text,
      rightIcon: /*this.loading ? CircularProgressIndicator() :*/ this.rightIcon,
    );
  }
}
