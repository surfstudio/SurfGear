import 'dart:collection';

import 'package:flutter/rendering.dart';
import 'package:render_metrics/src/data/comparison_diff.dart';
import 'package:render_metrics/src/data/render_data.dart';
import 'package:render_metrics/src/manager/render_manager.dart';
import 'package:render_metrics/src/render/render_metrics.dart';

/// Менеджер для работы с метриками виджетов
class RenderParametersManager<T> extends RenderManager<T> {
  HashMap<T, RenderMetricsBox> _renderObjects = HashMap();

  /// Добавить экземпляр [RenderObject]
  void addRenderObject(T id, RenderObject renderObject) {
    _renderObjects[id] = renderObject;
  }

  /// Получить экземпляр [RenderObject] по [id]
  RenderMetricsBox getRenderObject(T id, RenderMetricsBox renderObject) {
    return _renderObjects[id];
  }

  /// Получить экземпляр [RenderData] по [id]
  RenderData getRenderData(T id) {
    return _renderObjects[id].data;
  }

  /// Получить разницу между
  /// двумя экземплярами [RenderObject]
  ComparisonDiff getDiff(T id0, T id1) {
    RenderData first = getRenderData(id0);
    RenderData second = getRenderData(id1);
    return first - second;
  }
}
