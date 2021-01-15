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

import 'package:render_metrics/src/data/comparison_diff.dart';
import 'package:render_metrics/src/data/coords_metrics.dart';

/// Widget metric data class
/// [yTop] - top Y position relative to the screen
/// [yBottom] - lower Y position relative to the screen
/// [yCenter] - center Y position relative to the screen
/// [xLeft] - left X position relative to the screen
/// [xRight] - right X position relative to the screen
/// [xCenter] - center X position relative to the screen
/// [width] - element width
/// [height] - element height
/// [topLeft] - upper left coordinate
/// [topRight] - upper right coordinate
/// [bottomLeft] - lower left coordinate
/// [bottomRight] - lower right coordinate
/// [center] - central coordinate
/// [topCenter] - upper center coordinate
/// [bottomCenter] - lower central coordinate
/// [centerLeft] - center left coordinate
/// [centerRight] - center right coordinate
class RenderData {
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

  final double? yTop;
  final double? yBottom;
  final double? yCenter;
  final double? xLeft;
  final double? xRight;
  final double? xCenter;
  final double? width;
  final double? height;

  CoordsMetrics get topLeft => CoordsMetrics(y: yTop, x: xLeft);

  CoordsMetrics get topRight => CoordsMetrics(y: yTop, x: xRight);

  CoordsMetrics get bottomLeft => CoordsMetrics(y: yBottom, x: xLeft);

  CoordsMetrics get bottomRight => CoordsMetrics(y: yBottom, x: xRight);

  CoordsMetrics get center => CoordsMetrics(y: yCenter, x: xCenter);

  CoordsMetrics get topCenter => CoordsMetrics(y: yTop, x: xCenter);

  CoordsMetrics get bottomCenter => CoordsMetrics(y: yBottom, x: xCenter);

  CoordsMetrics get centerLeft => CoordsMetrics(y: yCenter, x: xLeft);

  CoordsMetrics get centerRight => CoordsMetrics(y: yCenter, x: xRight);

  /// Returns the difference between
  /// the external and the current instance ofRenderData,
  /// as an instance of the ComparisonDiff class
  ComparisonDiff? operator -(RenderData? other) {
    if (other == null) return null;
    return ComparisonDiff(
      firstData: this,
      secondData: other,
      yTop: _nnSubtract(yTop, other.yTop),
      yBottom: _nnSubtract(yBottom, other.yBottom),
      yCenter: _nnSubtract(yCenter, other.yCenter),
      xLeft: _nnSubtract(xLeft, other.xLeft),
      xRight: _nnSubtract(xRight, other.xRight),
      xCenter: _nnSubtract(xCenter, other.xCenter),
      diffTopToBottom: _nnSubtract(yTop, other.yBottom),
      diffBottomToTop: _nnSubtract(yBottom, other.yTop),
      diffLeftToRight: _nnSubtract(xLeft, other.xRight),
      diffRightToLeft: _nnSubtract(xRight, other.xLeft),
      width: _nnSubtract(width, other.width),
      height: _nnSubtract(height, other.height),
    );
  }

  double? _nnSubtract(double? minuend, double? subtrahend) {
    // ignore: avoid_returning_null
    if (minuend == null || subtrahend == null) return null;
    return minuend - subtrahend;
  }

  @override
  String toString() {
    return 'RenderData(\n'
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
