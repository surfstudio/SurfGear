import 'package:push/push.dart';

/// Абстрактная факбрика для стратегий обработки пуш уведомлений
abstract class PushHandleStrategyFactory {
  /// ключ события в data firebase'вского пуша
  /// Можно настроить свой формат в релизации фабрики
  String key = "event";

  /// Переопределяем с необходимым соответствием действий(типа пуша) и стратегий
  Map<String, BasePushHandleStrategy> get map;

  /// Возвращает стратегию по данным пуша
  BasePushHandleStrategy createByData(Map<String, dynamic> messageData) {
    return map[messageData[key]]..extractDataFromMap(messageData);
  }
}
