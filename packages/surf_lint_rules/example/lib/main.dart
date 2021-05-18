import 'package:surf_lint_rules/surf_lint_rules.dart';

Future<void> asyncFunction() => Future.value();

Future<void> main() async {
  await asyncFunction();

  unawaited(asyncFunction());
}

class Example {
  static const staticConst = 42;

  static final staticFinal = staticConst.isEven;

  static String staticString = '42';

  final String stringField;
  String nonFinalString;

  void foo() {
    return;
  }

  Example({
    required this.stringField,
    required this.nonFinalString,
  });
}
