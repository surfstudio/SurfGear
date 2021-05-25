import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mwwm/src/utils/composite_subscription.dart';

import 'mocks/steam_subscription_mock.dart';

void main() {
  group('CompositeSubscription', () {
    late CompositeSubscription compositeSubscription;
    late StreamSubscriptionMock<Object> streamSubscriptionMock;

    setUp(() {
      compositeSubscription = CompositeSubscription();

      streamSubscriptionMock = StreamSubscriptionMock<Object>();
      when(streamSubscriptionMock.cancel)
          .thenAnswer((_) => Future<void>.value());
    });

    test('isDisposed returns false if no called dispose()', () {
      expect(compositeSubscription.isDisposed, isFalse);
    });

    group('add()', () {
      test('returns subscription', () {
        expect(
          compositeSubscription.add<Object>(streamSubscriptionMock),
          streamSubscriptionMock,
        );
      });

      test('no emits throw if isDisposed is false', () {
        expect(
          () => compositeSubscription.add<Object>(streamSubscriptionMock),
          returnsNormally,
        );
      });

      test('emits throw if isDisposed is true', () {
        compositeSubscription.dispose();

        expect(
          () => compositeSubscription.add<Object>(streamSubscriptionMock),
          throwsA(isException),
        );
      });

      group('remove', () {
        test('calls subscription.cancel()', () {
          compositeSubscription
            ..add<Object>(streamSubscriptionMock)
            ..remove(streamSubscriptionMock);

          verify(streamSubscriptionMock.cancel);
        });
      });

      group('clear', () {
        test('calls clear for all streamSubscription', () {
          final streamSubscriptionMock1 = StreamSubscriptionMock<Object>();
          when(streamSubscriptionMock1.cancel)
              .thenAnswer((_) => Future<void>.value());

          compositeSubscription
            ..add<Object>(streamSubscriptionMock)
            ..add<Object>(streamSubscriptionMock1)
            ..clear();

          verify(streamSubscriptionMock.cancel);
          verify(streamSubscriptionMock1.cancel);
        });
      });

      group('dispose', () {
        test('calls clear()', () {
          compositeSubscription
            ..add<Object>(streamSubscriptionMock)
            ..dispose();

          verify(streamSubscriptionMock.cancel);
        });
      });
    });
  });
}
