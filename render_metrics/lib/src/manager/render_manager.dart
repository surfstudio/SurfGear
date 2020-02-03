import 'package:flutter/rendering.dart';

/// Base class for rendering interaction managers
abstract class RenderManager<T> {
  /// Handling the RenderObject Add Call
  void addRenderObject(T id, RenderObject object);

  /// Handling the RenderObject Delete Call
  void removeRenderObject(T id);
}
