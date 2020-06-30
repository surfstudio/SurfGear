import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pedantic/pedantic.dart';
import 'package:relation/relation.dart';

void main() {
  testWidgets(
    'StreamedStateBuilder accept test',
    (WidgetTester tester) async {
      final testData = EntityStreamedState<String>(EntityState(data: 'test'));

      final streamedStateBuilder = EntityStateBuilder<String>(
        streamedState: testData,
        child: (context, data) {
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
      expect(streamedStateBuilder.streamedState.value.data, 'test');
      final testFinder = find.text('test');
      expect(testFinder, findsOneWidget);

      await testData.error();
    },
  );

  testWidgets(
    'StreamedStateBuilder error test',
    (WidgetTester tester) async {
      final testData = EntityStreamedState<String>();
      final streamedStateBuilder = EntityStateBuilder<String>(
        streamedState: testData,
        child: (context, data) {
          return Text('test');
        },
        errorChild: Text('error_text'),
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
    },
  );

  testWidgets(
    'StreamedStateBuilder loading test',
    (WidgetTester tester) async {
      final testData = EntityStreamedState<String>();
      final streamedStateBuilder = EntityStateBuilder<String>(
        streamedState: testData,
        child: (context, data) {
          return Text('test');
        },
        loadingChild: Text('loading_child'),
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
    },
  );
}
