import 'package:client_common/views/simple_page.dart';
import 'package:flutter/cupertino.dart';

class Page404 extends StatelessWidget {
  static PageRouteBuilder pageRoutebuilder(RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, _a, _b) {
        return Page404();
      },
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      child: Center(
        child: Text("Page not found"),
      ),
    );
  }
}
