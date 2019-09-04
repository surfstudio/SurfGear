import 'package:push/push.dart';
import 'package:rxdart/subjects.dart';

typedef HandleMessageFunction = void Function(
    Map<String, dynamic> message, MessageHandlerType handlerType);

/// Notification handling
class PushHandler {
  PushHandler(
    this._strategyFactory,
    this._notificationController,
    this._messagingService,
  ) {
    _messagingService.initNotification(handleMessage);
  }

  /// The ability to directly subscribe to receive messages
  final PublishSubject<Map<String, dynamic>> messageSubject = PublishSubject();
  final BehaviorSubject<PushHandleStrategy> selectNotificationSubject =
      BehaviorSubject();

  final PushHandleStrategyFactory _strategyFactory;
  final NotificationController _notificationController;
  final MessagingService _messagingService;

  void handleMessage(
    Map<String, dynamic> message,
    MessageHandlerType handlerType, {
    bool localNotification = false,
  }) {
    if (!localNotification) {
      messageSubject.add(message);
    }

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
