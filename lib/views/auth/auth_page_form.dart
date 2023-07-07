// import 'package:client_common/models/auth_model.dart';
// import 'package:client_common/models/status.dart';
// import 'package:client_common/views/auth/login_form.dart';
// import 'package:client_common/views/auth/register_form.dart';
// import 'package:flutter/material.dart';
// import 'package:lenra_components/component/lenra_text.dart';
// import 'package:lenra_components/lenra_components.dart';
// import 'package:logging/logging.dart';
// import 'package:provider/provider.dart';

// class AuthPageForm extends StatefulWidget {
//   final bool? isRegisterPage;
//   AuthPageForm(this.isRegisterPage, {Key? key}) : super(key: key);

//   @override
//   State<AuthPageForm> createState() => _AuthPageFormState();
// }

// class _AuthPageFormState extends State<AuthPageForm> {
//   final logger = Logger('AuthPageForm');

//   bool isRegisterPage = true;
//   var themeData = LenraThemeData();

//   String? redirectTo;
//   String? appServiceName;

//   @override
//   void initState() {
//     super.initState();
//     isRegisterPage = widget.isRegisterPage ?? true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     redirectTo = context.read<AuthModel>().redirectToRoute;
//     print("redirectTo $redirectTo");
//     RegExp regExp = RegExp(r"app\/([a-fA-F0-9-]{36})");
//     final match = regExp.firstMatch(redirectTo ?? "/");
//     appServiceName = match?.group(1);
//     print("appServiceName $appServiceName");

//     return LenraFlex(
//       spacing: 32,
//       direction: Axis.vertical,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       fillParent: true,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: LenraColorThemeData.greySuperLight,
//             borderRadius: BorderRadius.circular(32),
//           ),
//           child: LenraFlex(
//             spacing: 16,
//             children: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   if (!isRegisterPage) {
//                     setState(() {
//                       context.read<AuthModel>().loginStatus = Status();
//                       context.read<AuthModel>().registerStatus = Status();
//                       isRegisterPage = true;
//                     });
//                   }
//                 },
//                 child: LenraText(
//                   text: "Register",
//                   style: isRegisterPage
//                       ? TextStyle(color: LenraColorThemeData.lenraWhite)
//                       : TextStyle(color: LenraColorThemeData.lenraBlue),
//                 ),
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.resolveWith((states) {
//                     if (isRegisterPage) {
//                       return LenraColorThemeData.lenraBlue;
//                     }
//                     return LenraColorThemeData.greySuperLight;
//                   }),
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32),
//                     ),
//                   ),
//                   fixedSize: MaterialStateProperty.all(Size(136, 36)),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   if (isRegisterPage) {
//                     setState(() {
//                       context.read<AuthModel>().loginStatus = Status();
//                       context.read<AuthModel>().registerStatus = Status();
//                       isRegisterPage = false;
//                     });
//                   }
//                 },
//                 child: LenraText(
//                   text: "Login",
//                   style: !isRegisterPage
//                       ? TextStyle(color: LenraColorThemeData.lenraWhite)
//                       : TextStyle(color: LenraColorThemeData.lenraBlue),
//                 ),
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.resolveWith((states) {
//                     if (!isRegisterPage) {
//                       return LenraColorThemeData.lenraBlue;
//                     }
//                     return LenraColorThemeData.greySuperLight;
//                   }),
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32),
//                     ),
//                   ),
//                   fixedSize: MaterialStateProperty.all(Size(136, 36)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         isRegisterPage ? RegisterForm() : LoginForm(),
//       ],
//     );
//   }
// }
