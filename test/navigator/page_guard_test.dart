import 'package:client_common/navigator/page_guard.dart';
import 'package:flutter/widgets.dart';
import 'package:test/test.dart';

void main() {
  test('PageGuard asserts', () {
    expect(() => PageGuard(guards: []), throwsA(isA<AssertionError>()));
    PageGuard(guards: [], child: Container()); // Does not throw
    PageGuard(guards: [], builder: (_) => Container()); // Does not throw
    expect(
        () => PageGuard(guards: [], child: Container(), builder: (_) => Container()), throwsA(isA<AssertionError>()));
  });
}
