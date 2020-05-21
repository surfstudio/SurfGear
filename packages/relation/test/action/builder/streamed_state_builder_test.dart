import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:relation/relation.dart';

void main() {
  testWidgets(
    'StreamedStateBuilder test',
    (WidgetTester tester) async {
      final testData = StreamedState<String>('test');
      final streamedStateBuilder = StreamedStateBuilder<String>(
          streamedState: testData,
          builder: (context, data) {
            return Text(data);
          });
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: streamedStateBuilder,
          ),
        ),
      );
      final textFinder = find.text('test');
      expect(textFinder, findsOneWidget);
    },
  );
}
