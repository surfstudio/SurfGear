import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:relation/relation.dart';

void main() {
  testWidgets(
    'ScrollOffsetAction test',
    (WidgetTester tester) async {
      final action = ScrollOffsetAction((onChanged) {
        expect(1.0, onChanged);
      });

      await tester.pumpWidget(MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('test'),
          ),
          body: ListView(
            controller: action.controller,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Text('test'),
              Text('test'),
              Text('test'),
            ],
          ),
        ),
      ));

      action.controller.jumpTo(1.0);
    },
  );

  testWidgets(
    'ScrollOffsetAction dispose test',
    (WidgetTester tester) async {
      final action = ScrollOffsetAction();

      await tester.pumpWidget(MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('test'),
          ),
          body: ListView(
            controller: action.controller,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Text('test'),
              Text('test'),
              Text('test'),
            ],
          ),
        ),
      ));

      action.dispose();
      expect(action.subject.isClosed, true);
    },
  );
}
