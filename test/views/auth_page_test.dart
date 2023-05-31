import 'package:client_common/models/auth_model.dart';
import 'package:client_common/views/auth/auth_page.dart';
import 'package:client_common/views/auth/auth_page_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('expect AuthPage to build correctly', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider<AuthModel>(
      create: (_) => AuthModel(),
      child: MaterialApp(
        home: LenraTheme(
          themeData: LenraThemeData(),
          child: AuthPage(),
        ),
      ),
    ));

    final finder = find.byType(AuthPageForm);
    expect(finder, findsOneWidget);
  });
}
