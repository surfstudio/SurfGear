import 'package:meta/meta.dart';
import 'package:surf_lint_rules/surf_lint_rules.dart';

import 'async_function.dart';

Future<void> main() async {
  await asyncFunction();

  unawaited(asyncFunction());
}

class OrderExample {
  static const staticConst = 42;

  static const _staticConst = staticConst;

  static final staticFinal = staticConst.isEven;

  // ignore: unused_field
  static final _staticFinal = _staticConst.isEven;

  static var staticField = 42;

  // ignore: prefer_final_fields, unused_field
  static var _staticField = 42;

  final fin = 42;

  final String finalField;

  // ignore: unused_field
  final _fin = 42;

  String publicField;

  String get string => publicField.toString();

  // Should be fixed by Dart Code Metrics's developers
  // ignore: member-ordering-extended
  set string(String newString) => publicField = newString;

  // ignore: prefer_final_fields, unused_field
  String _privateField = '42';

  // ignore: unused_element
  String get _field => _privateField;

  // Should be fixed by Dart Code Metrics's developers
  // ignore: member-ordering-extended, unused_element
  set _field(String newString) => _privateField = '42';

  OrderExample({
    required this.finalField,
    required this.publicField,
  });

  OrderExample.empty()
      : finalField = '',
        publicField = '';

  factory OrderExample.factored(
    String finalField,
    String publicField,
  ) =>
      OrderExample(
        finalField: finalField,
        publicField: publicField,
      );

  @override
  String toString() {
    return super.toString().substring(0);
  }

  // ignore: member-ordering-extended
  static void staticFoo() {
    return;
  }

  // ignore: member-ordering-extended
  void foo() {
    return;
  }

  // ignore: member-ordering-extended
  @protected
  void protectedFoo() {
    return;
  }

  // ignore: unused_element
  static void _staticFoo() {
    return;
  }

  // ignore: member-ordering-extended, unused_element
  void _foo() {
    return;
  }
}
