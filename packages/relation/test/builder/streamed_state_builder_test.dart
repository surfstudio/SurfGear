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
import 'package:relation/relation.dart';

import '../test_utils.dart';

const _testNotNullString = 'test';
const _defaultString = 'def';

void main() {
  testWidgets('StreamedStateBuilder nullable test', (tester) async {
    final testStreamedState = StreamedState<String?>(null);
    final streamedStateBuilder = StreamedStateBuilder<String?>(
      streamedState: testStreamedState,
      builder: (context, data) {
        return Text(data ?? _defaultString);
      },
    );
    await tester.pumpWidget(makeTestableWidget(streamedStateBuilder));
    expect(find.text(_defaultString), findsOneWidget);
    await testStreamedState.accept(_testNotNullString);
    await tester.pump();
    expect(find.text(_testNotNullString), findsOneWidget);
  });

  testWidgets('StreamedStateBuilder not nullable test', (tester) async {
    final testStreamedState = StreamedState<int>(0);
    final streamedStateBuilder = StreamedStateBuilder<int>(
      streamedState: testStreamedState,
      builder: (context, data) {
        return Text(data.toString());
      },
    );
    await tester.pumpWidget(makeTestableWidget(streamedStateBuilder));
    expect(find.text(0.toString()), findsOneWidget);
    await testStreamedState.accept(1);
    await tester.pump();
    expect(find.text(1.toString()), findsOneWidget);
  });
}
