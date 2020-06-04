import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:render_metrics/src/data/render_data.dart';
import 'package:render_metrics/src/manager/render_manager.dart';

typedef void MountCallback<T>(T id, RenderMetricsBox box);
typedef void UnMountCallback<T>(T id);

/// [RenderObjectWidget] for getting widget metrics
/// [id] - widget id
/// [manager] - an instance of the RenderManager for getting and processing metrics
/// [onMount] - mount / create instance callback [RenderMetricsObject]
/// [onUnMount] - unmount / uninstall instance callback [RenderMetricsObject]
///
/// When mounting a RenderMetricsObject, the createRenderObject method fires.
/// It calls onMount if the manager addRenderObject method
/// is also passed if it is passed.
/// When deleted from the tree, didUnmountRenderObject is triggered.
/// It calls onUnMount if passed and the removeRenderObject method
class RenderMetricsObject<T> extends SingleChildRenderObjectWidget {
  final T id;
  final RenderManager manager;
  final MountCallback onMount;
  final UnMountCallback onUnMount;

  const RenderMetricsObject({
    Key key,
    Widget child,
    this.id,
    this.manager,
    this.onMount,
    this.onUnMount,
  })  : assert(manager == null || id != null && manager != null),
        super(key: key, child: child);

  RenderMetricsBox createRenderObject(BuildContext context) {
    final r = RenderMetricsBox();
    onMount?.call(id, r);
    manager?.addRenderObject(id, r);
    return r;
  }

  void didUnmountRenderObject(covariant RenderObject renderObject) {
    manager?.removeRenderObject(id);
    onUnMount?.call(id);
  }
}

/// [RenderBox] for getting widget metrics
/// extends RenderProxyBox which extends RenderObject
/// [data] - getter for receiving data in the instance [RenderData]
class RenderMetricsBox extends RenderProxyBox {
  RenderData get data {
    Size size = this.size;
    double width = size.width;
    double height = size.height;
    Offset globalOffset = localToGlobal(Offset(width, height));
    double dy = globalOffset.dy;
    double dx = globalOffset.dx;

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

  RenderMetricsBox({
    RenderBox child,
  }) : super(child);
}
