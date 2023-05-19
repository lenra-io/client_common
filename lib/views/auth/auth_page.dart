import 'package:client_common/views/loading_button.dart';
import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';
import 'package:lenra_components/component/lenra_text.dart';
import 'package:lenra_components/component/lenra_text_form_field.dart';
import 'package:lenra_components/layout/lenra_flex.dart';

class AppAuthPage extends StatefulWidget {
  @override
  State<AppAuthPage> createState() => _AppAuthPageState();
}

class _AppAuthPageState extends State<AppAuthPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      child: LenraFlex(
        direction: Axis.vertical,
        children: [
          Container(
            width: 100,
            height: 100,
          ),
          LenraText(text: "App Name"),
          LenraFlex(
            children: [
              LenraText(text: "by"),
              Image.asset("assets/images/logo-horizontal-white.png"),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.info_outline),
              )
            ],
          ),
          Container(
            child: LenraFlex(
              children: [
                TextButton(
                  onPressed: () {},
                  child: LenraText(text: "Inscription"),
                ),
                TextButton(
                  onPressed: () {},
                  child: LenraText(text: "Connexion"),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: LenraFlex(
              children: [
                LenraTextFormField(
                  label: "Your email",
                ),
                LenraTextFormField(
                  label: "Your password",
                ),
                LoadingButton(
                  text: "Log in",
                  onPressed: () {},
                  loading: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
