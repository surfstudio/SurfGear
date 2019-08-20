import 'package:push/src/push_manager.dart';

/// Абстрактная стратегия
abstract class PushHandleStrategy {
  /// обработка сообщения
  void handleMessage(
      Map<String, dynamic> message, MessageHandlerType handlerType);
}
