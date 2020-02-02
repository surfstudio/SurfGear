import 'package:render_metrics/src/data/render_data.dart';

/// Объект с данными о разнице метрик рендера между двумя объектами [RenderData]
/// Разница рссчитывается [firstData] - [secondData]
/// [firstData] - превый экземпляр [RenderData]
/// [secondData] - второй экземпляр [RenderData]
/// [yTop] - разница верхних Y позиция относительно экрана
/// [yBottom] - разница нижних Y позиция относительно экрана
/// [yCenter] - разница центральной Y позиция относительно экрана
/// [xLeft] - разница левых X позиция относительно экрана
/// [xRight] - разница правых X позиция относительно экрана
/// [xCenter] - разница центральной X позиция относительно экрана
/// [width] - разница ширины элементов
/// [height] - разница высот элементов
class ComparisonDiff {
  final RenderData firstData;
  final RenderData secondData;
  final double yTop;
  final double yBottom;
  final double yCenter;
  final double xLeft;
  final double xRight;
  final double xCenter;
  final double width;
  final double height;

  ComparisonDiff({
    this.firstData,
    this.secondData,
    this.yTop,
    this.yBottom,
    this.yCenter,
    this.xLeft,
    this.xRight,
    this.xCenter,
    this.width,
    this.height,
  });

  @override
  String toString() {
    return 'ComparisonDiff(\n'
        '    yTop = $yTop;\n'
        '    yBottom = $yBottom;\n'
        '    yCenter = $yCenter;\n'
        '    xLeft = $xLeft;\n'
        '    xRight = $xRight;\n'
        '    xCenter = $xCenter;\n'
        '    width = $width;\n'
        '    height = $height;\n'
        ')';
  }
}
