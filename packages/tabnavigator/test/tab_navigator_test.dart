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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tabnavigator/tabnavigator.dart';

void main() {
  late StreamController<TestTab> _tabController;

  setUp(() {
    _tabController = StreamController<TestTab>.broadcast(sync: true);
  });

  group('TabNavigator', () {
    testWidgets('smoke test', (tester) async {
      const _initTab = TestTab.first;

      Stream<TestTab> tabStream() => _tabController.stream;

      final _map = {
        TestTab.first: () => Container(color: Colors.white),
        TestTab.second: () => Container(color: Colors.blue),
        TestTab.third: () => Container(color: Colors.red),
      };

      final _widget = MaterialApp(
        home: Scaffold(
          body: TabNavigator(
            initialTab: _initTab,
            selectedTabStream: tabStream(),
            mappedTabs: _map,
          ),
        ),
      );

      await tester.pumpWidget(_widget);
    });

    testWidgets('navigation between tabs', (tester) async {
      const _initTab = TestTab.first;

      const _keys = [
        Key('first'),
        Key('second'),
        Key('third'),
      ];

      final _map = {
        TestTab.first: () => Container(color: Colors.white, key: _keys[0]),
        TestTab.second: () => Container(color: Colors.blue, key: _keys[1]),
        TestTab.third: () => Container(color: Colors.red, key: _keys[2]),
      };

      Stream<TestTab> tabStream() => _tabController.stream;

      final _widget = MaterialApp(
        home: Scaffold(
          body: TabNavigator(
            initialTab: _initTab,
            selectedTabStream: tabStream(),
            mappedTabs: _map,
          ),
        ),
      );

      await tester.pumpWidget(_widget);

      // current tab is first with white color
      expect(
        find.descendant(
          of: find.byType(TabNavigator),
          matching: find.byKey(_keys[0]),
        ),
        findsWidgets,
      );

      expect(
        find.descendant(
          of: find.byType(TabNavigator),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is Container &&
                (widget.color == Colors.blue || widget.color == Colors.red),
          ),
        ),
        findsNothing,
      );

      // set current tab to second with blue color
      _tabController.sink.add(TestTab.second);
      await tester.pump();

      // current tab is second with blue color
      expect(
        find.descendant(
          of: find.byType(TabNavigator),
          matching: find.byKey(_keys[1]),
        ),
        findsWidgets,
      );

      expect(
        find.descendant(
          of: find.byType(TabNavigator),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is Container &&
                (widget.color == Colors.red || widget.color == Colors.white),
          ),
        ),
        findsNothing,
      );
    });

    testWidgets('deep navigation', (tester) async {
      const _initTab = TestTab.first;

      const _keys = [
        Key('first'),
        Key('second'),
        Key('third'),
      ];

      final _map = {
        TestTab.first: () {
          return Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: Container(
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
              child: Container(color: Colors.white, key: _keys[0]),
            );
          });
        },
        TestTab.second: () => Container(color: Colors.blue, key: _keys[1]),
        TestTab.third: () => Container(color: Colors.red, key: _keys[2]),
      };

      Stream<TestTab> tabStream() => _tabController.stream;

      final _widget = MaterialApp(
        home: Scaffold(
          body: TabNavigator(
            initialTab: _initTab,
            selectedTabStream: tabStream(),
            mappedTabs: _map,
          ),
          bottomNavigationBar: StreamBuilder<TestTab>(
            stream: tabStream(),
            initialData: _initTab,
            builder: (context, snapshot) {
              return BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.feedback),
                    label: 'Feed',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.color_lens),
                    label: 'Colors',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.info),
                    label: 'Info',
                  ),
                ],
                currentIndex: snapshot.hasData ? snapshot.data!.value : 0,
                onTap: (value) =>
                    _tabController.sink.add(TestTab.byValue(value)),
              );
            },
          ),
        ),
      );

      await tester.pumpWidget(_widget);

      // current tab is first with white color
      expect(
        find.descendant(
          of: find.byType(TabNavigator),
          matching: find.byKey(_keys[0]),
        ),
        findsWidgets,
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.green,
        ),
        findsNothing,
      );

      await tester.tap(find.byKey(_keys[0]));
      await tester.pumpAndSettle();

      // this means that we're at second screen of first tab
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.green,
        ),
        findsWidgets,
      );

      await tester.tap(find.byIcon(Icons.color_lens));
      await tester.pumpAndSettle();

      // current tab is second with blue color
      expect(
        find.descendant(
          of: find.byType(TabNavigator),
          matching: find.byKey(_keys[0]),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(TabNavigator),
          matching: find.byKey(_keys[1]),
        ),
        findsWidgets,
      );
    });
  });

  tearDown(() async {
    await _tabController.close();
  });
}

class TestTab extends TabType {
  const TestTab._(int value) : super(value);

  static const first = TestTab._(0);
  static const second = TestTab._(1);
  static const third = TestTab._(2);

  static TestTab byValue(int value) {
    switch (value) {
      case 0:
        return first;
      case 1:
        return second;
      case 2:
        return third;
      default:
        throw Exception('no tab for such value');
    }
  }
}
