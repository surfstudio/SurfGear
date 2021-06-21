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
import 'package:pedantic/pedantic.dart';
import 'package:relation/relation.dart';

void main() {
  testWidgets(
    'TextfieldStreamBuilder content test',
    (tester) async {
      final testData = TextFieldStreamedState('test');
      final textFieldStateBuilder = TextFieldStateBuilder(
        state: testData,
        stateBuilder: (context, data) {
          return const Text('test');
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: textFieldStateBuilder,
          ),
        ),
      );

      final textFinder = find.text('test');
      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'TextfieldStreamBuilder error test',
    (tester) async {
      final testData = TextFieldStreamedState('test');

      final textFieldStateBuilder = TextFieldStateBuilder(
        state: testData,
        stateBuilder: (context, data) {
          if (data != null && data.hasError) {
            return const Text('error');
          }
          return const Text('test');
        },
      );

      unawaited(testData.error());
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: textFieldStateBuilder,
          ),
        ),
      );

      final textFinder = find.text('error');
      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'TextfieldStreamBuilder loading test',
    (tester) async {
      final testData = TextFieldStreamedState('test');

      final textFieldStateBuilder = TextFieldStateBuilder(
        state: testData,
        stateBuilder: (context, data) {
          if (data != null && data.isLoading) {
            return const Text('loading');
          }
          return const Text('test');
        },
      );

      unawaited(testData.loading());
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: textFieldStateBuilder,
          ),
        ),
      );

      final textFinder = find.text('loading');
      expect(textFinder, findsOneWidget);
    },
  );
}
