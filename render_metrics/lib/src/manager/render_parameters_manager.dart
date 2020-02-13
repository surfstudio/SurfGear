import 'dart:collection';

import 'package:flutter/rendering.dart';
import 'package:render_metrics/src/data/comparison_diff.dart';
import 'package:render_metrics/src/data/render_data.dart';
import 'package:render_metrics/src/manager/render_manager.dart';
import 'package:render_metrics/src/render/render_metrics.dart';

/// Manager for working with widget metrics
class RenderParametersManager<T> extends RenderManager<T> {
  HashMap<T, RenderMetricsBox> _renderObjects = HashMap();

  RenderMetricsBox operator [](T id) {
    return _renderObjects[id];
  }

  /// Add an instance [RenderObject]
  void addRenderObject(T id, RenderObject renderObject) {
    _renderObjects[id] = renderObject;
  }

  /// Get an instance of [RenderObject] by [id]
  RenderMetricsBox getRenderObject(T id, RenderMetricsBox renderObject) {
    return _renderObjects[id];
  }

  /// Get an instance of [RenderData] by [id]
  RenderData getRenderData(T id) {
    return _renderObjects[id].data;
  }

  /// Delete an instance of [RenderObject] by id
  void removeRenderObject(T id) {
    _renderObjects.remove(id);
  }

  /// Get the difference between
  /// two instances [RenderObject]
  ComparisonDiff getDiff(T firstId, T secondId) {
    RenderData first = getRenderData(firstId);
    RenderData second = getRenderData(secondId);
    return first - second;
  }
}
