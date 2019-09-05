import 'package:build_context_holder/build_context_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestWidget extends StatefulWidget {
  @override
  TestWidgetState createState() => TestWidgetState();
}

class TestWidgetState extends State<TestWidget>
    with BuildContextHolderStateMixin<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestWidget title'),
      ),
    );
  }
}

void main() {
  testWidgets('Holder testing', (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          BuildContextHolder.instance.context = context;
          expect(context, BuildContextHolder.instance.context);
          return Placeholder();
        },
      ),
    );
  });

  testWidgets('Mixin testing', (WidgetTester tester) async {
    BuildContextHolder.instance.context = null;
    await tester.pumpWidget(
      MaterialApp(
        home: TestWidget(),
      ),
    );
    expect(BuildContextHolder.instance.context, isNotNull);
  });
}
