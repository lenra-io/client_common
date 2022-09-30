import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';

class InvitePage extends StatefulWidget {
  @override
  final String uuid;

  const InvitePage({Key? key, required this.uuid}) : super(key: key);

  State<StatefulWidget> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return SimplePage();
    // final LenraTextThemeData finalLenraTextThemeData = LenraTheme.of(context).lenraTextThemeData;

    // AuthModel authModel = context.read<AuthModel>();

    // return SimplePage(
    //   child: LenraFlex(
    //     direction: Axis.vertical,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       LenraText(text: "You are invited yo join the application : " + appName),
    //       LenraText(text: "You are logged with : " + authModel.user!.email),
    //       LenraText(text: "Would you accepot invitation ?"),
    //       LenraButton(text: "Accept", onPressed: () {}),
    //       RichText(
    //         text: TextSpan(
    //           text: "Change my account",
    //           style: finalLenraTextThemeData.blueBodyText,
    //           recognizer: TapGestureRecognizer()
    //             ..onTap = () {
    //               authModel.logout();
    //             },
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
