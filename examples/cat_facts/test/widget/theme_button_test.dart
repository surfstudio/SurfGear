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

import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/ui/screen/facts/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/src/testing_tools.dart';

void main() {
  group('ThemeButton builds', () {
    testWidgets('for light theme', (tester) async {
      await tester.pumpWidgetBuilder(
        const ThemeButton(theme: AppTheme.light),
      );

      expect(find.text('Switch Off'), findsOneWidget);
      expect(find.text('Switch On'), findsNothing);

      final typeFinder = find.byWidgetPredicate(
        (widget) {
          if (widget is! Icon) {
            return false;
          }

          return widget.icon == Icons.brightness_3;
        },
      );

      expect(typeFinder, findsOneWidget);
    });

    testWidgets('for dark theme', (tester) async {
      await tester.pumpWidgetBuilder(
        const ThemeButton(theme: AppTheme.dark),
      );

      expect(find.text('Switch Off'), findsNothing);
      expect(find.text('Switch On'), findsOneWidget);

      final typeFinder = find.byWidgetPredicate((widget) {
        if (widget is! Icon) {
          return false;
        }

        return widget.icon == Icons.brightness_7;
      });

      expect(typeFinder, findsOneWidget);
    });
  });
}
