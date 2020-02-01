import 'package:flutter/rendering.dart';

/// Базовый класс для менеджеров взаимодействия с рендером
abstract class RenderManager<T> {
  void addRenderObject(T id, RenderObject object);
}
