import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:render_metrics/src/data/render_data.dart';
import 'package:render_metrics/src/manager/render_manager.dart';

/// [RenderObject] для получения метрик виджета
/// [id] - id виджета
/// [manager] - экземпляр RenderManager для болучения и обработки метрик
class RenderMetricsObject extends SingleChildRenderObjectWidget {
  final dynamic id;
  final RenderManager manager;

  const RenderMetricsObject({
    Key key,
    Widget child,
    this.id,
    this.manager,
  })  : assert(id != null && manager != null),
        super(key: key, child: child);

  @override
  RenderMetricsBox createRenderObject(BuildContext context) {
    final r = RenderMetricsBox();
    manager.addRenderObject(id, r);
    return r;
  }

  @override
  void didUnmountRenderObject(covariant RenderObject renderObject) {
    manager.removeRenderObject(id);
  }
}

/// [RenderBox] для получения метрик виджета
/// [data] - геттер для получения данных в экземпляре [RenderData]
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
