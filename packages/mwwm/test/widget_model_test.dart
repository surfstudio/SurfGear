import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mwwm/src/dependencies/wm_dependencies.dart';
import 'package:mwwm/src/widget_model.dart';

import 'mocks/error_handler_mock.dart';
import 'mocks/steam_subscription_mock.dart';
import 'mocks/stream_mock.dart';
import 'mocks/widget_model_mock.dart';

void main() {
  group('WidgetModel', () {
    late WidgetModel widgetModel;
    late ErrorHandlerMock errorHandlerMock;
    late StreamController<int> streamController;
    late Completer<int> completer;
    const value = 1;

    setUp(() {
      errorHandlerMock = ErrorHandlerMock();
      streamController = StreamController<int>();
      completer = Completer<int>.sync();
      widgetModel = WidgetModelMock(
        WidgetModelDependencies(errorHandler: errorHandlerMock),
      );
    });

    group('subscribe', () {
      test('returns StreamSubscription', () {
        expect(
          widgetModel.subscribe(streamController.stream, (t) {}),
          isA<StreamSubscription<int>>(),
        );
      });

      test('uses onValue handle on stream', () {
        widgetModel.subscribe(streamController.stream, (v) {
          expect(v, equals(value));
        });

        streamController
          ..add(value)
          ..close();
      });

      test('uses onError handle on stream', () {
        widgetModel.subscribe(streamController.stream, (t) {}, onError: (v) {
          expect(v, equals(value));
        });

        streamController
          ..addError(value)
          ..close();
      });
    });

    group('subscribeHandleError', () {
      test('returns StreamSubscription', () {
        expect(
          widgetModel.subscribeHandleError(streamController.stream, (t) {}),
          isA<StreamSubscription<int>>(),
        );
      });

      test('subscribes onValue handle on stream', () {
        widgetModel.subscribeHandleError(streamController.stream, (v) {
          expect(v, equals(value));
        });

        streamController
          ..add(value)
          ..close();
      });

      test('subscribes onError handle on stream', () {
        void verifyFunc(Object v) {
          verify(() => errorHandlerMock.handleError(value));
          expect(v, equals(value));
        }

        widgetModel.subscribeHandleError(
          streamController.stream,
          (t) {},
          onError: verifyFunc,
        );

        streamController
          ..addError(value)
          ..close();
      });
    });

    group('doFuture', () {
      test('calls onValue after complete Future', () {
        late int res;
        widgetModel.doFuture<int>(completer.future, (value) {
          res = value;
        });
        completer.complete(value);
        expect(res, equals(value));
      });

      test('calls onError after throw Error', () {
        widgetModel.doFuture<int>(
          completer.future,
          (value) {
            throw Exception();
          },
          onError: (e) {
            expect(e, isException);
          },
        );
        completer.complete(value);
      });
    });

    group('doFutureHandleError', () {
      test('calls onValue after complete Future', () {
        late int res;
        widgetModel.doFutureHandleError<int>(completer.future, (newValue) {
          res = newValue;
        });
        completer.complete(value);
        expect(res, equals(value));
      });

      test('calls onError after throw Error', () {
        FutureOr<int> onValue(int c) {
          throw Exception();
        }

        widgetModel.doFutureHandleError<int>(
          completer.future,
          onValue,
          onError: (e) {
            expect(e, isException);
          },
        );

        completer.complete(value);
        verify(() => errorHandlerMock.handleError(any()));
      });
    });

    group('dispose', () {
      test('call cancel for stream', () {
        final streamMock = StreamMock<Object>();

        final streamSubscription = StreamSubscriptionMock<Object>();
        when(streamSubscription.cancel).thenAnswer((_) => Future.value());
        when(() => streamMock.listen(any())).thenReturn(streamSubscription);

        widgetModel
          ..subscribe(streamMock, (t) {})
          ..dispose();

        verify(streamSubscription.cancel);
      });
    });
  });
}
