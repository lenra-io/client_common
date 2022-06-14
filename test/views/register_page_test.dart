import 'package:client_common/models/auth_model.dart';
import 'package:client_common/views/register/register_form.dart';
import 'package:client_common/views/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('expect RegisterPage to build correctly', (WidgetTester tester) async {
    await tester.pumpWidget(ChangeNotifierProvider<AuthModel>(
      create: (_) => AuthModel(),
      child: MaterialApp(
        home: LenraTheme(
          themeData: LenraThemeData(),
          child: RegisterPage(),
        ),
      ),
    ));
    final finder = find.byType(RegisterForm);
    expect(finder, findsOneWidget);
  });
}
