import 'package:client_common/views/simple_page.dart';
import 'package:flutter/material.dart';

class InvitationPage extends StatefulWidget {
  @override
  final String uuid;

  const InvitationPage({Key? key, required this.uuid}) : super(key: key);

  State<StatefulWidget> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return SimplePage();
  }
}
