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

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_widget/src/disable_widget.dart';

import 'utils.dart';

void main() {
  group('DisableWidget builds', () {
    testWidgets(
      "with passed color if we don't pass decoration",
      (tester) async {
        await tester.pumpWidget(
          makeTestableWidget(
            const DisableWidget(color: Colors.white, opacity: 0.5),
          ),
        );

        final typeFinder = find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.white,
        );

        expect(typeFinder, findsOneWidget);
      },
    );

    testWidgets('without passed color if we pass decoration', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          const DisableWidget(
            color: Colors.white,
            opacity: 0.5,
            decoration: ShapeDecoration(shape: RoundedRectangleBorder()),
          ),
        ),
      );

      final typeFinder = find.byWidgetPredicate(
        (widget) => widget is Container && widget.color == null,
      );

      expect(typeFinder, findsOneWidget);
    });

    testWidgets(
      "without decoration if we don't pass decaration and shape border",
      (tester) async {
        await tester.pumpWidget(
          makeTestableWidget(
            const DisableWidget(
              color: Colors.white,
              opacity: 0.5,
            ),
          ),
        );

        final typeFinder = find.byWidgetPredicate(
          (widget) => widget is Container && widget.decoration == null,
        );

        expect(typeFinder, findsOneWidget);
      },
    );

    testWidgets('with passed decoration', (tester) async {
      const decoration = ShapeDecoration(shape: RoundedRectangleBorder());

      await tester.pumpWidget(
        makeTestableWidget(
          const DisableWidget(
            color: Colors.white,
            opacity: 0.5,
            decoration: decoration,
          ),
        ),
      );

      final typeFinder = find.byWidgetPredicate(
        (widget) => widget is Container && widget.decoration == decoration,
      );

      expect(typeFinder, findsOneWidget);
    });

    testWidgets(
      'with default decoration if passed shape for it',
      (tester) async {
        const shape = RoundedRectangleBorder();

        await tester.pumpWidget(
          makeTestableWidget(
            const DisableWidget(
              color: Colors.white,
              opacity: 0.5,
              key: Key('example'),
              defaultDecorationShape: shape,
            ),
          ),
        );

        final typeFinder = find.byWidgetPredicate((widget) =>
            widget is Container &&
            widget.decoration is ShapeDecoration &&
            (widget.decoration as ShapeDecoration).shape == shape);

        expect(typeFinder, findsOneWidget);
      },
    );
  });
}
