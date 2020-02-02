import 'package:flutter/rendering.dart';

/// Базовый класс для менеджеров взаимодействия с рендером
abstract class RenderManager<T> {
  /// Обработка вызова добавления RenderObject
  void addRenderObject(T id, RenderObject object);

  /// Обработка вызова удаления RenderObject
  void removeRenderObject(T id);
}
