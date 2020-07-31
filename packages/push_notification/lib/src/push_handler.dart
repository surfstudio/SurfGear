import 'package:push_notification/push_notification.dart';
import 'package:push_notification/src/base/base_messaging_service.dart';
import 'package:push_notification/src/base/push_handle_strategy_factory.dart';
import 'package:push_notification/src/notification/notification_controller.dart';
import 'package:push_notification/src/push_navigator_holder.dart';
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
    _messagingService?.initNotification(handleMessage);
  }

  /// The ability to directly subscribe to receive messages
  final PublishSubject<Map<String, dynamic>> messageSubject = PublishSubject();
  final BehaviorSubject<PushHandleStrategy> selectNotificationSubject =
      BehaviorSubject();

  final PushHandleStrategyFactory _strategyFactory;
  final NotificationController _notificationController;
  final BaseMessagingService _messagingService;

  /// display local notification
  /// MessagingService calls this method to display the notification that
  /// came from message service
  void handleMessage(
    Map<String, dynamic> message,
    MessageHandlerType handlerType, {
    bool localNotification = false,
  }) {
    if (!localNotification) {
      messageSubject.add(message);
    }

    final strategy = _strategyFactory.createByData(message);
    if (message != null) {
      if (handlerType == MessageHandlerType.onLaunch ||
          handlerType == MessageHandlerType.onResume) {
        strategy.onBackgroundProcess(message);
      }
      if (handlerType == MessageHandlerType.onMessage) {
        _notificationController.show(
          strategy,
          (_) {
            selectNotificationSubject.add(strategy);
            strategy.onTapNotification(PushNavigatorHolder().navigator);
          },
        );
      }
    }
  }
}
