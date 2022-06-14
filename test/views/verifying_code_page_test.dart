import 'package:client_common/models/auth_model.dart';
import 'package:client_common/views/verify_code/verifiying_code_page.dart';
import 'package:client_common/views/verify_code/verify_code_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'lenra_page_test_help.dart';

void main() {
  testWidgets('expect VerifyingCodePage to build correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createAppTestWidgets(ChangeNotifierProvider<AuthModel>(
      create: (_) => AuthModel(),
      child: VerifyingCodePage(),
    )));
    final finder = find.byType(VerifyCodeForm);
    expect(finder, findsOneWidget);
  });
}
