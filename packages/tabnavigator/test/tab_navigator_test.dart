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
  final _tabController = StreamController<TestTab>.broadcast();

  group('TabNavigator', () {
    testWidgets('smoke test', (tester) async {
      const _initTab = TestTab.first;

      Stream<TestTab> tabStream() => _tabController.stream;

      final _map = <TestTab, TabBuilder>{
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

      expect(true, isTrue);
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
  static const third = TestTab._(3);

  static TestTab byType(int value) {
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
