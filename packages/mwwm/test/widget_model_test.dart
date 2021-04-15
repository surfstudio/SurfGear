import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mwwm/src/widget_model.dart';
import 'package:mwwm/src/dependencies/wm_dependencies.dart';

import 'mocks/error_handler_mock.dart';
import 'mocks/widget_model_mock.dart';

void main() {
  group('WidgetModel', () {
    late WidgetModel widgetModel;
    late ErrorHandlerMock errorHandlerMock;
    late StreamController<int> streamController;
    const value = 1;

    void func(Object v) {
      expect(v, value);
    }

    setUp(() {
      errorHandlerMock = ErrorHandlerMock();
      streamController = StreamController<int>();
      widgetModel = WidgetModelMock(
          WidgetModelDependencies(errorHandler: errorHandlerMock));
    });

    group('subscribe', () {
      test('return StreamSubscription', () {
        expect(widgetModel.subscribe(streamController.stream, (t) {}),
            isA<StreamSubscription<int>>());
      });

      test('subscribe onValue handle on stream', () {
        widgetModel.subscribe(streamController.stream, func);

        streamController
          ..add(value)
          ..close();
      });

      test('subscribe onError handle on stream', () {
        widgetModel.subscribe(streamController.stream, (t) {}, onError: func);

        streamController
          ..addError(value)
          ..close();
      });
    });

    group('subscribeHandleError', () {
      test('return StreamSubscription', () {
        expect(
            widgetModel.subscribeHandleError(streamController.stream, (t) {}),
            isA<StreamSubscription<int>>());
      });

      test('subscribe onValue handle on stream', () {
        widgetModel.subscribeHandleError(streamController.stream, func);

        streamController
          ..add(value)
          ..close();
      });

      test('subscribe onError handle on stream', () {
        void verifyFunc(Object v) {
          verify(() => errorHandlerMock.handleError(value));
          expect(v, value);
        }

        widgetModel.subscribeHandleError(streamController.stream, (t) {},
            onError: verifyFunc);

        streamController
          ..addError(value)
          ..close();
      });
    });

  });
}
