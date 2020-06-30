import 'package:flutter_template/config/env/env.dart';
import 'package:push_notification/push_notification.dart';

/// Интерактор для работы с <DebugScreen>
class DebugScreenInteractor {
  DebugScreenInteractor(this._pushHandler);

  final PushHandler _pushHandler;

  void showDebugScreenNotification() {
    if (Environment.instance().isDebug) {
      _pushHandler.handleMessage(
        {
          'notification': {
            'title': 'Open debug screen',
            'body': '',
          },
          'event': 'debug',
          'data': {
            'event': 'debug',
          },
        },
        MessageHandlerType.onMessage,
        localNotification: true,
      );
    }
  }
}
