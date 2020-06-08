# render_metrics

A library that helps to perform actions with some periodicity

## Usage of RenderMetrics

main classes:

1. [RenderMetricsObject](/lib/src/render/render_metrics.dart)
2. [RenderMetricsBox](/lib/src/render/render_metrics.dart)
3. [RenderManager](/lib/src/manager/render_manager.dart)
4. [RenderParametersManager](/lib/src/manager/render_parameters_manager.dart)

usage:

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