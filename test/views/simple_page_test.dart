import 'package:client_common/views/simple_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'lenra_page_test_help.dart';

void main() {
  testWidgets('Basic SimplePage', (WidgetTester tester) async {
    await tester.pumpWidget(createAppTestWidgets(SimplePage()));

    final widgetFinder = find.byType(SimplePage);
    final logoFinder = find.byType(Image);
    final textFinder = find.byType(Text);

    expect(widgetFinder, findsOneWidget);
    expect(logoFinder, findsOneWidget);
    expect(textFinder, findsNWidgets(0));
  });
  testWidgets('SimplePage with title', (WidgetTester tester) async {
    var title = "My title";

    await tester.pumpWidget(createAppTestWidgets(SimplePage(
      title: title,
    )));

    final widgetFinder = find.byType(SimplePage);
    final logoFinder = find.byType(Image);
    final textFinder = find.byType(Text);
    final titleFinder = find.text(title);

    expect(widgetFinder, findsOneWidget);
    expect(logoFinder, findsOneWidget);
    expect(textFinder, findsNWidgets(1));
    expect(titleFinder, findsOneWidget);
  });
  testWidgets('SimplePage with title and content', (WidgetTester tester) async {
    var title = "My title";
    var content = "My text";

    await tester.pumpWidget(createAppTestWidgets(SimplePage(
      title: title,
      child: Text(content),
    )));

    final widgetFinder = find.byType(SimplePage);
    final logoFinder = find.byType(Image);
    final textFinder = find.byType(Text);
    final titleFinder = find.text(title);
    final contentFinder = find.text(content);

    expect(widgetFinder, findsOneWidget);
    expect(logoFinder, findsOneWidget);
    expect(textFinder, findsNWidgets(2));
    expect(titleFinder, findsOneWidget);
    expect(contentFinder, findsOneWidget);
  });
  testWidgets('SimplePage full', (WidgetTester tester) async {
    var title = "My title";
    var back = "Get back";
    var content = "My text";

    await tester.pumpWidget(createAppTestWidgets(SimplePage(
      title: title,
      backInkText: back,
      child: Text(content),
    )));

    final widgetFinder = find.byType(SimplePage);
    final logoFinder = find.byType(Image);
    final textFinder = find.byType(Text);
    final titleFinder = find.text(title);
    final backFinder = find.text(back);
    final contentFinder = find.text(content);

    expect(widgetFinder, findsOneWidget);
    expect(logoFinder, findsOneWidget);
    expect(textFinder, findsNWidgets(3));
    expect(titleFinder, findsOneWidget);
    expect(backFinder, findsOneWidget);
    expect(contentFinder, findsOneWidget);
  });
}
