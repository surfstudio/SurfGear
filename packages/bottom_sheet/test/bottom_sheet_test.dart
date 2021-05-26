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

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:bottom_sheet/src/widgets/flexible_bottom_sheet_scroll_notifyer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'scroll.dart';
import 'test_utils.dart';

void main() {
  group('Smoke tests', () {
    testWidgets('FlexibleDraggableScrollableSheet builds', (tester) async {
      final widget = FlexibleDraggableScrollableSheet(
        builder: (context, scrollController) {
          return ListView.builder(
            controller: scrollController,
            itemCount: 25,
            itemBuilder: (context, index) {
              return ListTile(title: Text('Item $index'));
            },
          );
        },
      );

      await tester.pumpWidget(makeTestableWidget(widget));
    });

    testWidgets('FlexibleScrollNotifyer builds', (tester) async {
      final widget = FlexibleScrollNotifyer(
        scrollStartCallback: (_) {
          return true;
        },
        scrollingCallback: (_) {
          return true;
        },
        scrollEndCallback: (_) {
          return true;
        },
        child: ListView.builder(
          itemCount: 25,
          itemBuilder: (context, index) {
            return ListTile(title: Text('Item $index'));
          },
        ),
      );

      await tester.pumpWidget(makeTestableWidget(widget));
    });
  });

  group('FlexibleScrollNotifyer', () {
    testWidgets('scroll callbacks', (tester) async {
      final result = <Scroll>[];

      final widget = FlexibleScrollNotifyer(
        scrollStartCallback: (_) {
          result.add(Scroll.start);
          return true;
        },
        scrollingCallback: (_) {
          result.add(Scroll.scrolling);
          return true;
        },
        scrollEndCallback: (_) {
          result.add(Scroll.end);
          return true;
        },
        child: FlexibleDraggableScrollableSheet(
          builder: (context, scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: 25,
              itemBuilder: (context, index) {
                return ListTile(title: Text('Item $index'));
              },
            );
          },
        ),
      );

      await tester.pumpWidget(makeTestableWidget(widget));

      final gesture = await tester.startGesture(const Offset(250, 300));

      expect(result, [Scroll.start]);

      await gesture.moveBy(const Offset(0, 50));

      expect(result, contains(Scroll.scrolling));

      await gesture.up();

      expect(result.last, equals(Scroll.end));
    });
  });
}
