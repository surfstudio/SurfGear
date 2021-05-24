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

import 'package:bottom_navigation_bar/src/bottom_nav_tab_type.dart';
import 'package:bottom_navigation_bar/src/bottom_navigation_relationship.dart';
import 'package:bottom_navigation_bar/src/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _greenKey = Key('greenButton');
const _redKey = Key('redButton');
const _blueKey = Key('blueButton');

const _types = [
  BottomNavTabType(0),
  BottomNavTabType(1),
  BottomNavTabType(2),
];

final _map = {
  _types[0]: BottomNavigationRelationship(
    tabBuilder: () => const SizedBox(child: Text('Red')),
    navElementBuilder: (isSelected) => _buildButton(
      _redKey,
      isSelected,
      const Color(0x55FF0000),
    ),
  ),
  _types[1]: BottomNavigationRelationship(
    tabBuilder: () => const SizedBox(child: Text('Green')),
    navElementBuilder: (isSelected) => _buildButton(
      _greenKey,
      isSelected,
      const Color(0x5500FF00),
    ),
  ),
  _types[2]: BottomNavigationRelationship(
    tabBuilder: () => const SizedBox(child: Text('Blue')),
    navElementBuilder: (isSelected) => _buildButton(
      _blueKey,
      isSelected,
      const Color(0x550000FF),
    ),
  ),
};

// ignore: avoid-returning-widgets
Widget _buildButton(Key key, bool isSelected, Color color) {
  return Container(
    key: key,
    height: 100,
    color: color,
    child: isSelected ? const Center(child: Icon(Icons.check)) : Container(),
  );
}

void main() {
  testWidgets('Red tap', (tester) async {
    await _buttonTest(_redKey, 'Red', tester);
  });

  testWidgets('Green tap', (tester) async {
    await _buttonTest(_greenKey, 'Green', tester);
  });

  testWidgets('Blue tap', (tester) async {
    await _buttonTest(_blueKey, 'Blue', tester);
  });

  testWidgets('Outer action', (tester) async {
    final sc = StreamController<BottomNavTabType>.broadcast();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BottomNavigator(
          initialTab: _types[0],
          tabsMap: _map,
          selectController: sc,
        ),
      ),
    ));

    sc.sink.add(_types[2]);

    await tester.pump();

    expect(find.text('Blue'), findsOneWidget);

    // ignore: unawaited_futures
    sc.close();
  });
}

Future<void> _buttonTest(Key key, String result, WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: BottomNavigator(
        initialTab: _types[0],
        tabsMap: _map,
        selectController: StreamController<BottomNavTabType>.broadcast(),
      ),
    ),
  ));

  await tester.tap(find.byKey(key).first);

  await tester.pump();

  expect(find.text(result), findsOneWidget);
}
