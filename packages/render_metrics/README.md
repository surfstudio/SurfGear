# render_metrics

![](logo.png)

#### [SurfGear](https://github.com/surfstudio/SurfGear)
[![pub package](https://img.shields.io/pub/v/render_metrics?label=render_metrics)](https://pub.dev/packages/render_metrics)

A library that helps to perform actions with some periodicity
## Usage of RenderMetrics

main classes:

1. [RenderMetricsObject](./lib/src/render/render_metrics.dart)
2. [RenderMetricsBox](./lib/src/render/render_metrics.dart)
3. [RenderManager](./lib/src/manager/render_manager.dart)
4. [RenderParametersManager](./lib/src/manager/render_parameters_manager.dart)
5. [RenderData](./lib/src/data/render_data.dart)
6. [ComparisonDiff](./lib/src/data/comparison_diff.dart)
7. [CoordsMetrics](./lib/src/data/coords_metrics.dart)

# Library for getting widget metrics.

Allows you to get the sizes of widgets even without their explicit indication and coordinates relative to the screen.

## Classes in the library

### Render classes
**RenderMetricsObject** - Descendant of SingleChildRenderObjectWidget. Accepts the widget from which to get metrics.

**RenderMetricsBox** - descendant of RenderProxyBox. Provides metric data.

### Data classes
**RenderData** - class provides widget metrics data.

**CoordsMetrics** - coordinate point class.

**ComparisonDiff** - class with a difference of coordinates between two RenderData
List of available values:

### Managers
**RenderManager** - Base class for the manager. Your own managers should inherit from it.
**RenderParametersManager** - Ready Render Manager successor storing the RenderMetricsBox list and functionality for working with them.
____

## Metric Data Provided

### double data:
**width** - Widget width.

**height** - Widget height.

**yTop** - Top Y position relative to the screen.

**yBottom** - Lower Y position relative to the screen.

**yCenter** - Center Y position relative to the screen.

**xLeft** - Left X position relative to the screen.

**xRight** - Right X position relative to the screen.

**xCenter** - Center X position relative to the screen.

### CoordsMetrics Instances:
**topLeft** - Upper left coordinate.

**topRight** - Upper right coordinate.

**bottomLeft** - Lower left coordinate.

**bottomRight** - Lower right coordinate.

**center** - Central coordinate.

**topCenter** - Upper center coordinate.

**bottomCenter** - Lower central coordinate.

**centerLeft** - Center left coordinate.

**centerRight** - Center right coordinate.

![](metrics_image.jpg)
____

## RenderData difference data in ComparisonDiff
**yTop** - Difference of the upper Y position relative to the screen.

**yBottom** - Difference of the lower Y position relative to the screen.

**yCenter** - Difference of the central Y position relative to the screen.

**xLeft** - Difference left X position relative to the screen.

**xRight** - Difference of the right X position relative to the screen.

**xCenter** - Difference of the central X position relative to the screen.

**diffTopToBottom** - Difference of the upper border.

**diffBottomToTop** - Difference of the lower border.

**diffLeftToRight** - Difference of the left border.

**diffRightToLeft** - Difference of the right border.

**width** - Difference in width of elements.

**height** - Difference in element heights.

**topLeft** - The difference between the upper left coordinates.

**topRight** - The difference between the upper right coordinates.

**bottomLeft** - The difference between the lower left coordinates.

**bottomRight** - The difference between the lower right coordinates.

**center** - The difference between the central coordinates.

**topCenter** - The difference between the upper center coordinates.

**bottomCenter** - The difference between the lower center coordinates.

**centerLeft** - The difference between the central left coordinates.

**centerRight** - The difference between the center right coordinates.
![](diff_image.jpg)

## RenderParametersManager functionality
**addRenderObject** - Add an instance of RenderObject.

**getRenderObject** - Add an instance of RenderObject by id.

**getRenderData** - Get an instance of RenderData with metrics. widget by id.

**removeRenderObject** - Remove an instance of RenderObject.


## Usage:

1. Wrap the widget from which you want to get metrics (size, position, etc.) in [RenderMetricsObject].
2. Pass the id. Only required when using RenderManager.
3. onMount method - will work when creating a RenderObject.
Takes in the parameters:
Passed id.
An instance of the RenderMetricsBox - the successor to the RenderProxyBox.
4. The onUnMount method will work when deleting widgets from the tree.
Takes in the parameters:
Passed id.
5. manager - an optional parameter. Waiting for a RenderManager descendant.
[RenderParametersManager] - a ready-made descendant of the RenderManager.
Allows you to get widget metrics:
Position and dimensions in [RenderData]
The difference between the two [RenderData] in the class instance [ComparisonDiff]
You can use your heir [RenderManager].