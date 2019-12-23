import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

/// утилиты-расширения для [WidgetModel]
extension SurfMwwmExtension on WidgetModel {
  /// bind ui [Event]'s
  void bind<T>(
    Event<T> event,
    void Function(T t) onValue, {
    void Function(dynamic e) onError,
  }) =>
      subscribe<T>(event.stream, onValue, onError: onError);
}
