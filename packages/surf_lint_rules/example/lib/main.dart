// ignore_for_file: unused_element, prefer_final_fields, unused_field
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

  static final _staticFinal = _staticConst.isEven;

  static var staticField = 42;

  static var _staticField = 42;

  final fin = 42;

  final String finalField;

  final _fin = 42;

  String publicField;

  String get string => publicField.toString();

  set string(String newString) => publicField = newString;

  String _privateField = '42';

  String get _field => _privateField;

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

  static void staticFoo() {
    return;
  }

  void foo() {
    return;
  }

  @protected
  void protectedFoo() {
    return;
  }

  static void _staticFoo() {
    return;
  }

  void _foo() {
    return;
  }
}
