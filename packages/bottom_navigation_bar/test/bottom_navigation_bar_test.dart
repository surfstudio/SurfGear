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
import 'dart:ui';

import 'package:bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Key _greenKey = const Key('greenButton');
Key _redKey = const Key('redButton');
Key _blueKey = const Key('blueButton');

List<BottomNavTabType> _types = [
  BottomNavTabType(0),
  BottomNavTabType(1),
  BottomNavTabType(2),
];

Map<BottomNavTabType, BottomNavigationRelationship> _map = {
  _types[0]: BottomNavigationRelationship(
    tabBuilder: () => _buildPage('Red'),
    navElementBuilder: (isSelected) => _buildButton(
      _redKey,
      isSelected,
      const Color(0x55FF0000),
    ),
  ),
  _types[1]: BottomNavigationRelationship(
    tabBuilder: () => _buildPage('Green'),
    navElementBuilder: (isSelected) => _buildButton(
      _greenKey,
      isSelected,
      const Color(0x5500FF00),
    ),
  ),
  _types[2]: BottomNavigationRelationship(
    tabBuilder: () => _buildPage('Blue'),
    navElementBuilder: (isSelected) => _buildButton(
      _blueKey,
      isSelected,
      const Color(0x550000FF),
    ),
  ),
};

Widget _buildButton(Key key, bool isSelected, Color color) {
  return Container(
    key: key,
    height: 100,
    color: color,
    child: isSelected
        ? const Center(
            child: Icon(Icons.check),
          )
        : Container(),
  );
}

Widget _buildPage(String color) {
  return SizedBox(
    child: Text(color),
  );
}

void main() {
  setUp(() {});

  tearDown(() {});

  redButtonTest();
  greenButtonTest();
  blueButtonTest();
  outerActionTest();
}

void redButtonTest() {
  testWidgets('Red tap', (tester) async {
    await _buttonTest(_redKey, 'Red', tester);
  });
}

void greenButtonTest() {
  testWidgets('Green tap', (tester) async {
    await _buttonTest(_greenKey, 'Green', tester);
  });
}

void blueButtonTest() {
  testWidgets('Blue tap', (tester) async {
    await _buttonTest(_blueKey, 'Blue', tester);
  });
}

void outerActionTest() {
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
