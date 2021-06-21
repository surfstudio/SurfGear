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
  testWidgets('EntityStateBuilder accept test', (tester) async {
    final testData =
        EntityStreamedState<String>(const EntityState(data: 'test'));

    final streamedStateBuilder = EntityStateBuilder<String>(
      streamedState: testData,
      builder: (context, data) {
        return Text(data);
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: streamedStateBuilder,
        ),
      ),
    );
    final testFinder = find.text('test');
    expect(testFinder, findsOneWidget);
  });

  testWidgets('EntityStateBuilder error test', (tester) async {
    final testData = EntityStreamedState<String>();
    final streamedStateBuilder = EntityStateBuilder<String>(
      streamedState: testData,
      builder: (context, data) {
        return const Text('test');
      },
      errorChild: const Text('error_text'),
    );

    unawaited(testData.error(Exception()));
    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: streamedStateBuilder,
        ),
      ),
    );

    final errorFinder = find.text('error_text');
    expect(errorFinder, findsOneWidget);
  });

  testWidgets('EntityStateBuilder loading test', (tester) async {
    final testData = EntityStreamedState<String>();
    final streamedStateBuilder = EntityStateBuilder<String>(
      streamedState: testData,
      builder: (context, data) {
        return const Text('test');
      },
      loadingChild: const Text('loading_child'),
    );

    unawaited(testData.loading());
    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: streamedStateBuilder,
        ),
      ),
    );

    final loadingFinder = find.text('loading_child');
    expect(loadingFinder, findsOneWidget);
  });

  testWidgets('EntityStateBuilder with loadingBuilder', (tester) async {
    final testData = EntityStreamedState<String>();
    final streamedStateBuilder = EntityStateBuilder<String>(
      streamedState: testData,
      builder: (context, data) {
        return const Text('test');
      },
      loadingBuilder: (context, data) => const Text('loadingBuilder'),
    );

    unawaited(testData.loading());
    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: streamedStateBuilder,
        ),
      ),
    );

    final loadingBuilderFinder = find.text('loadingBuilder');
    expect(loadingBuilderFinder, findsOneWidget);
  });

  testWidgets('EntityStateBuilder with errorChild', (tester) async {
    final testData = EntityStreamedState<String>();
    final streamedStateBuilder = EntityStateBuilder<String>(
      streamedState: testData,
      builder: (context, data) {
        return const Text('test');
      },
      errorChild: const Text('errorChild'),
    );

    unawaited(testData.error());
    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: streamedStateBuilder,
        ),
      ),
    );

    final loadingBuilderFinder = find.text('errorChild');
    expect(loadingBuilderFinder, findsOneWidget);
  });

  testWidgets('EntityStateBuilder with errorBuilder', (tester) async {
    final testData = EntityStreamedState<String>();
    final streamedStateBuilder = EntityStateBuilder<String>(
      streamedState: testData,
      builder: (context, data) {
        return const Text('test');
      },
      errorBuilder: (context, e) => const Text('errorBuilder'),
    );

    unawaited(testData.error());
    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: streamedStateBuilder,
        ),
      ),
    );

    final loadingBuilderFinder = find.text('errorBuilder');
    expect(loadingBuilderFinder, findsOneWidget);
  });

  testWidgets('EntityStateBuilder with errorDataBuilder passing data',
      (tester) async {
    final testData = EntityStreamedState<String>();
    final streamedStateBuilder = EntityStateBuilder<String>(
      streamedState: testData,
      builder: (context, data) {
        return const Text('test');
      },
      errorDataBuilder: (context, data, error) =>
          Text('errorDataBuilder $data'),
    );

    unawaited(testData.error(Exception(), 'data'));
    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: streamedStateBuilder,
        ),
      ),
    );

    final loadingBuilderFinder = find.text('errorDataBuilder data');
    expect(loadingBuilderFinder, findsOneWidget);
  });

  group('EntityStateBuilder order:', () {
    testWidgets('errorDataBuilder has hightest priority', (tester) async {
      final testData = EntityStreamedState<String>();
      final streamedStateBuilder = EntityStateBuilder<String>(
        streamedState: testData,
        builder: (context, data) {
          return const Text('test');
        },
        errorChild: const Text('errorChild'),
        errorBuilder: (context, error) => const Text('errorBuilder'),
        errorDataBuilder: (
          context,
          data,
          error,
        ) =>
            Text('errorDataBuilder $data'),
      );

      unawaited(testData.error(Exception(), 'data'));
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: streamedStateBuilder,
          ),
        ),
      );

      final loadingBuilderFinder = find.text('errorDataBuilder data');
      expect(loadingBuilderFinder, findsOneWidget);
    });
    testWidgets('errorBuilder has medium priority', (tester) async {
      final testData = EntityStreamedState<String>();
      final streamedStateBuilder = EntityStateBuilder<String>(
        streamedState: testData,
        builder: (context, data) {
          return const Text('test');
        },
        errorChild: const Text('errorChild'),
        errorBuilder: (context, error) => const Text('errorBuilder'),
      );

      unawaited(testData.error(Exception(), 'data'));
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: streamedStateBuilder,
          ),
        ),
      );

      final loadingBuilderFinder = find.text('errorBuilder');
      expect(loadingBuilderFinder, findsOneWidget);
    });

    testWidgets('errorBuilder has lowest priority', (tester) async {
      final testData = EntityStreamedState<String>();
      final streamedStateBuilder = EntityStateBuilder<String>(
        streamedState: testData,
        builder: (context, data) {
          return const Text('test');
        },
        errorChild: const Text('errorChild'),
      );

      unawaited(testData.error(Exception(), 'data'));
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: streamedStateBuilder,
          ),
        ),
      );

      final loadingBuilderFinder = find.text('errorChild');
      expect(loadingBuilderFinder, findsOneWidget);
    });
  });
}
