import 'package:push/push.dart';
import 'package:rxdart/subjects.dart';

/// Notification handling
class PushHandler {
  /// The ability to directly subscribe to receive messages
  final PublishSubject<Map<String, dynamic>> messageSubject = PublishSubject();
  final BehaviorSubject<PushHandleStrategy> selectNotificationSubject =
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
