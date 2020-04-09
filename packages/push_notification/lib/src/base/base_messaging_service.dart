import 'package:push_notification/src/push_handler.dart';

enum MessageHandlerType { onMessage, onLaunch, onResume }

/// Base wrapper over any message service
abstract class BaseMessagingService {
  /// no need to call. initialization is called inside the [PushHandler]
  void initNotification(HandleMessageFunction handleMessage);
}
