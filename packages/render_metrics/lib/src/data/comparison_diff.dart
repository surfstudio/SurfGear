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

import 'package:render_metrics/src/data/coords_metrics.dart';
import 'package:render_metrics/src/data/render_data.dart';

/// An object with data on the difference of render metrics between two objects
/// [RenderData]
/// The difference is calculated [firstData] - [secondData]
/// [firstData] - the first instance of [RenderData]
/// [secondData] - second instance [RenderData]
/// [yTop] - difference of the upper Y position relative to the screen
/// [yBottom] - difference of the lower Y position relative to the screen
/// [yCenter] - difference of the central Y position relative to the screen
/// [xLeft] - difference left X position relative to the screen
/// [xRight] - difference of the right X position relative to the screen
/// [xCenter] - difference of the central X position relative to the screen
/// [diffTopToBottom] - difference of the upper border [firstData] to the lower
/// border [secondData]
/// [diffBottomToTop] - difference of the lower border [firstData] to the upper
/// border [secondData]
/// [diffLeftToRight] - difference of the left border [firstData] to the right
/// border [secondData]
/// [diffRightToLeft] - difference of the right border [firstData] to the left
/// border [secondData]
/// [width] - difference in width of elements
/// [height] - difference in element heights
/// [topLeft] - upper left coordinate
/// [topRight] - upper right coordinate
/// [bottomLeft] - lower left coordinate
/// [bottomRight] - lower right coordinate
/// [center] - central coordinate
/// [topCenter] - upper center coordinate
/// [bottomCenter] - lower central coordinate
/// [centerLeft] - center left coordinate
/// [centerRight] - center right coordinate
class ComparisonDiff {
  ComparisonDiff({
    this.firstData,
    this.secondData,
    this.yTop,
    this.yBottom,
    this.yCenter,
    this.xLeft,
    this.xRight,
    this.xCenter,
    this.diffTopToBottom,
    this.diffBottomToTop,
    this.diffLeftToRight,
    this.diffRightToLeft,
    this.width,
    this.height,
  });

  final RenderData firstData;
  final RenderData secondData;
  final double yTop;
  final double yBottom;
  final double yCenter;
  final double xLeft;
  final double xRight;
  final double xCenter;
  final double diffTopToBottom;
  final double diffBottomToTop;
  final double diffLeftToRight;
  final double diffRightToLeft;
  final double width;
  final double height;

  CoordsMetrics get topLeft => CoordsMetrics(y: yTop, x: xLeft);

  CoordsMetrics get topRight => CoordsMetrics(y: yTop, x: xRight);

  CoordsMetrics get bottomLeft => CoordsMetrics(y: yBottom, x: xLeft);

  CoordsMetrics get bottomRight => CoordsMetrics(y: yBottom, x: xRight);

  CoordsMetrics get center => CoordsMetrics(y: yCenter, x: xCenter);

  CoordsMetrics get topCenter => CoordsMetrics(y: yTop, x: xCenter);

  CoordsMetrics get bottomCenter => CoordsMetrics(y: yBottom, x: xCenter);

  CoordsMetrics get centerLeft => CoordsMetrics(y: yCenter, x: xLeft);

  CoordsMetrics get centerRight => CoordsMetrics(y: yCenter, x: xRight);

  @override
  String toString() {
    return 'ComparisonDiff(\n'
        '    yTop = $yTop;\n'
        '    yBottom = $yBottom;\n'
        '    yCenter = $yCenter;\n'
        '    xLeft = $xLeft;\n'
        '    xRight = $xRight;\n'
        '    xCenter = $xCenter;\n'
        '    diffTopToBottom = $diffTopToBottom;\n'
        '    diffBottomToTop = $diffBottomToTop;\n'
        '    diffLeftToRight = $diffLeftToRight;\n'
        '    diffRightToLeft = $diffRightToLeft;\n'
        '    width = $width;\n'
        '    height = $height;\n'
        ')';
  }
}
