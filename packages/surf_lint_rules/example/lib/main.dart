// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// ignore_for_file: unused_element, prefer_final_fields, unused_field, type_annotate_public_apis
import 'package:meta/meta.dart';
import 'package:surf_lint_rules/surf_lint_rules.dart';

import 'package:example/async_function.dart';

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
