import 'package:render_metrics/src/data/comparison_diff.dart';

/// Объект с данными метрик рендера
/// [yTop] - верхняя Y позиция относительно экрана
/// [yBottom] - нижняя Y позиция относительно экрана
/// [yCenter] - центральная Y позиция относительно экрана
/// [xLeft] - левая X позиция относительно экрана
/// [xRight] - правая X позиция относительно экрана
/// [xCenter] - центральная X позиция относительно экрана
/// [width] - ширина элемента
/// [height] - высота элемента

class RenderData {
  final double yTop;
  final double yBottom;
  final double yCenter;
  final double xLeft;
  final double xRight;
  final double xCenter;
  final double width;
  final double height;

  RenderData({
    this.yTop,
    this.yBottom,
    this.yCenter,
    this.xLeft,
    this.xRight,
    this.xCenter,
    this.width,
    this.height,
  });

  ComparisonDiff operator -(RenderData other) {
    return ComparisonDiff(
      firstData: this,
      secondData: other,
      yTop: yTop - other.yTop,
      yBottom: yBottom - other.yBottom,
      yCenter: yTop + other.height / 2,
      xLeft: xLeft - other.xLeft,
      xRight: xRight - other.xRight,
      xCenter: xLeft - other.width / 2,
      width: width - other.width,
      height: height - other.height,
    );
  }

  @override
  String toString() {
    return 'ComparisonData(\n'
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
