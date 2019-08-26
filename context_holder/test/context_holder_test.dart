import 'package:context_holder/context_holder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
