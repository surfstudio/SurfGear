import 'package:push/push.dart';
import 'package:rxdart/subjects.dart';

/// Обработка нотификаций
class PushHandler {
  /// Возможность на прямую подписаться на получение сообщений
  final PublishSubject<Map<String, dynamic>> messageSubject = PublishSubject();
  final BehaviorSubject<BasePushHandleStrategy> selectNotificationSubject =
      BehaviorSubject();

  final PushHandleStrategyFactory _strategyFactory;
  final NotificationController _notificationController;

  PushHandler(
    this._strategyFactory,
    this._notificationController,
  );

  void messageHandler(
      Map<String, dynamic> message, MessageHandlerType handlerType) {
    messageSubject.add(message);

    var strategy = _strategyFactory.createByData(message);
    _notificationController.show(
      strategy,
      (_) {
        selectNotificationSubject.add(strategy);
        strategy.onTapNotification(PushNavigatorHolder().navigator);
      },
    );
  }
}
