import 'package:push/src/push_handle_strategy.dart';

/// Абстрактная факбрика для стратегий обработки пуш уведомлений
abstract class PushHandleStrategyFactory {
  /// ключ события в data firebase'вского пуша
  /// Можно настроить свой формат в релизации фабрики
  String key = "event";

  /// Переопределяем с необходимым соответствием действий(типа пуша) и стратегий
  Map<String, PushHandleStrategy> map();

  /// Возвращает стратегию по данным пуша
  PushHandleStrategy createByData(Map<String, dynamic> data) {
    return map()[data[key]];
  }
}
