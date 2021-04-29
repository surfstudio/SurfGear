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

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:push_notification/src/base/base_messaging_service.dart';
import 'package:push_notification/src/base/push_handle_strategy.dart';
import 'package:push_notification/src/base/push_handle_strategy_factory.dart';
import 'package:push_notification/src/notification/notification_controller.dart';
import 'package:push_notification/src/push_handler.dart';

class BaseMessagingServiceMock extends Mock implements BaseMessagingService {}

class PushHandleStrategyFactoryMock extends Mock
    implements PushHandleStrategyFactory {}

class PushHandleStrategyMock extends Mock implements PushHandleStrategy {}

class NotificationControllerMock extends Mock
    implements NotificationController {}

void main() {
  setUpAll(() {
    registerFallbackValue(PushHandleStrategyMock());
  });

  group('PushHandler', () {
    late PushHandler handler;

    late NotificationControllerMock notificationController;
    late PushHandleStrategyMock pushHandleStrategy;

    setUp(() {
      pushHandleStrategy = PushHandleStrategyMock();

      final pushHandleStrategyFactory = PushHandleStrategyFactoryMock();
      when(() => pushHandleStrategyFactory.createByData(any()))
          .thenReturn(pushHandleStrategy);

      notificationController = NotificationControllerMock();
      when(() => notificationController.requestPermissions(
            requestSoundPermission: any(named: 'requestSoundPermission'),
            requestAlertPermission: any(named: 'requestAlertPermission'),
          )).thenAnswer((_) => Future.value(true));
      when(() => notificationController.show(any(), any()))
          .thenAnswer((_) => Future<void>.value());

      handler = PushHandler(
        pushHandleStrategyFactory,
        notificationController,
        BaseMessagingServiceMock(),
      );
    });

    test(
      'requestPermissions request required permission from passed notification controller',
      () {
        handler.requestPermissions(
          soundPemission: false,
          alertPermission: true,
        );

        final args = verify(
          () => notificationController.requestPermissions(
            requestSoundPermission: captureAny(named: 'requestSoundPermission'),
            requestAlertPermission: captureAny(named: 'requestAlertPermission'),
          ),
        ).captured;
        expect(args, equals([false, true]));
      },
    );

    group('handleMessage process passed', () {
      test('global onLaunch message', () async {
        const message = {'message': 'simple on launch text'};

        final messages = <Map<String, dynamic>>[];
        handler.messageSubject.listen(messages.add);

        handler.handleMessage(message, MessageHandlerType.onLaunch);

        await handler.messageSubject.close();
        expect(messages, equals([message]));
        verify(() => pushHandleStrategy.onBackgroundProcess(message))
            .called(equals(1));
        verifyNever(() => notificationController.show(any(), any()));
      });

      test('local onResume message', () async {
        const message = {'message': 'simple on resume text'};

        final messages = <Map<String, dynamic>>[];
        handler.messageSubject.listen(messages.add);

        handler.handleMessage(
          message,
          MessageHandlerType.onResume,
          localNotification: true,
        );

        await handler.messageSubject.close();
        expect(messages, isEmpty);
        verify(() => pushHandleStrategy.onBackgroundProcess(message))
            .called(equals(1));
        verifyNever(() => notificationController.show(any(), any()));
      });

      test('local onMessage message', () async {
        const message = {'message': 'simple on message text'};

        final messages = <Map<String, dynamic>>[];
        handler.messageSubject.listen(messages.add);

        handler.handleMessage(
          message,
          MessageHandlerType.onMessage,
        );

        await handler.messageSubject.close();
        expect(messages, equals([message]));
        verifyNever(() => pushHandleStrategy.onBackgroundProcess(any()));
        verify(() => notificationController.show(any(), any()))
            .called(equals(1));
      });
    });
  });
}
