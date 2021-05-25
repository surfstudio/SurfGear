// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:render_metrics/src/data/render_data.dart';
import 'package:render_metrics/src/manager/render_manager.dart';

typedef MountCallback<T> = void Function(T id, RenderMetricsBox box);
typedef UnMountCallback<T> = void Function(T id);

/// [RenderObjectWidget] for getting widget metrics
/// [id] - widget id
/// [manager] - an instance of the RenderManager for getting and processing
/// metrics
/// [onMount] - mount / create instance callback [RenderMetricsObject]
/// [onUnMount] - unmounted / uninstall instance callback [RenderMetricsObject]
///
/// When mounting a RenderMetricsObject, the createRenderObject method fires.
/// It calls onMount if the manager addRenderObject method
/// is also passed if it is passed.
/// When deleted from the tree, didUnmountRenderObject is triggered.
/// It calls onUnMount if passed and the removeRenderObject method
class RenderMetricsObject<T> extends SingleChildRenderObjectWidget {
  const RenderMetricsObject({
    required this.id,
    required this.manager,
    this.onMount,
    this.onUpdate,
    this.onUnMount,
    Key? key,
    Widget? child,
  }) : super(key: key, child: child);

  final T id;
  final RenderManager manager;
  final MountCallback<T>? onMount;
  final MountCallback<T>? onUpdate;
  final UnMountCallback<T>? onUnMount;

  @override
  RenderMetricsBox createRenderObject(BuildContext context) {
    final r = RenderMetricsBox();
    onMount?.call(id, r);
    manager.addRenderObject(id, r);
    return r;
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderObject renderObject,
  ) {
    if (renderObject is RenderMetricsBox) {
      onUpdate?.call(id, renderObject);
      manager.updateRenderObject(id, renderObject);
    }
  }

  @override
  void didUnmountRenderObject(covariant RenderObject renderObject) {
    manager.removeRenderObject(id);
    onUnMount?.call(id);
  }
}

/// [RenderBox] for getting widget metrics
/// extends RenderProxyBox which extends RenderObject
/// [data] - getter for receiving data in the instance [RenderData]
class RenderMetricsBox extends RenderProxyBox {
  RenderMetricsBox({
    RenderBox? child,
  }) : super(child);

  RenderData get data {
    final size = this.size;
    final width = size.width;
    final height = size.height;
    final globalOffset = localToGlobal(Offset(width, height));
    final dy = globalOffset.dy;
    final dx = globalOffset.dx;

    return RenderData(
      yTop: dy - height,
      yBottom: dy,
      yCenter: dy - height / 2,
      xLeft: dx - width,
      xRight: dx,
      xCenter: dx - width / 2,
      width: width,
      height: height,
    );
  }
}
