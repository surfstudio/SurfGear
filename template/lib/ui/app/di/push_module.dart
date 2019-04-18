import 'package:flutter_template/interactor/common/push/notification/notification_controller.dart';
import 'package:flutter_template/interactor/common/push/push_manager.dart';
import 'package:injector/injector.dart';

///Модуль для пробрасывания зависимостей к [PushManager]
class PushModule extends Module<PushManager> {
  PushManager _pushManager = PushManager();

  @override
  PushManager provides() => _pushManager;
}

class NotificationControllerModule extends Module<NotificationController> {
  final _notificationController = NotificationController();

  @override
  NotificationController provides() => _notificationController;
}
