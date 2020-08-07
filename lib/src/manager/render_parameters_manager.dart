import 'dart:collection';

import 'package:flutter/rendering.dart';
import 'package:render_metrics/src/data/comparison_diff.dart';
import 'package:render_metrics/src/data/render_data.dart';
import 'package:render_metrics/src/manager/render_manager.dart';
import 'package:render_metrics/src/render/render_metrics.dart';

/// Manager class extending RenderManager.
/// Contains a collection of mounted RenderMetricsBox
/// and provides methods for working with it.
class RenderParametersManager<T> extends RenderManager<T> {
  final HashMap<T, RenderMetricsBox> _renderObjects = HashMap();

  /// Collection with mounted RenderMetricsBox
  RenderMetricsBox operator [](T id) {
    return _renderObjects[id];
  }

  /// Add Instance to _renderObjects Collection
  @override
  void addRenderObject(T id, RenderObject renderObject) {
    _renderObjects[id] = renderObject as RenderMetricsBox;
  }

  /// Get an instance of [RenderObject] by [id]
  RenderMetricsBox getRenderObject(T id) {
    return _renderObjects[id];
  }

  /// Get instance of [RenderData] from [RenderObject] by id
  RenderData getRenderData(T id) {
    return getRenderObject(id)?.data;
  }

  /// Delete an instance of [RenderObject] by id
  @override
  void removeRenderObject(T id) {
    _renderObjects.remove(id);
  }

  /// Get the difference between
  /// two instances [RenderObject] by id
  ComparisonDiff getDiffById(T firstId, T secondId) {
    final RenderData first = getRenderData(firstId);
    final RenderData second = getRenderData(secondId);
    return getDiffByInstance(first, second);
  }

  /// Get the difference between
  /// two instances [RenderObject] by Instance
  ComparisonDiff getDiffByInstance(RenderData first, RenderData second) {
    if (first == null || second == null) return null;
    return first - second;
  }
}
