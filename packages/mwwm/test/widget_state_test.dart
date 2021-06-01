import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mwwm/mwwm.dart';

import 'mocks/widget_model_mock.dart';

class TestWidget extends CoreMwwmWidget<WidgetModelMock> {
  const TestWidget({required WidgetModelBuilder<WidgetModelMock> widgetModelBuilder, Key? key})
      : super(
          key: key,
          widgetModelBuilder: widgetModelBuilder,
        );

  @override
  WidgetState<CoreMwwmWidget<WidgetModelMock>, WidgetModelMock> createWidgetState() {
    return TestWidgetState();
  }
}

class TestWidgetState extends WidgetState<TestWidget, WidgetModelMock> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

void main() {
  group('WidgetState', () {
    late TestWidget testWidget;
    late WidgetModelMock widgetModelMock;
    setUp(() {
      widgetModelMock = WidgetModelMock();
      testWidget = TestWidget(key: UniqueKey(), widgetModelBuilder: (context) => widgetModelMock);
    });
    testWidgets(
      'onLoad and onBind called on initState',
      (tester) async {
        await tester.pumpWidget(testWidget);
        verify(() => widgetModelMock.onLoad());
        verify(() => widgetModelMock.onBind());
      },
    );
  });
}
