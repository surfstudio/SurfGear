# render_metrics

A library that helps to perform actions with some periodicity

## Usage of RenderMetrics

main classes:

1. [RenderMetricsObject](/lib/src/render/render_metrics.dart)
2. [RenderMetricsBox](/lib/src/render/render_metrics.dart)
3. [RenderManager](/lib/src/manager/render_manager.dart)
4. [RenderParametersManager](/lib/src/manager/render_parameters_manager.dart)

usage:

1. Wrap the widget from which you want to get metrics (position, dimensions, etc.) in [RenderMetricsObject]
2. Use a ready-made manager to work with metrics [RenderParametersManager] or use your own inheriting [RenderManager]
3. In the application, pass the same [RenderManager] instance to the RenderMetricsObject instances as an argument
4. [RenderParametersManager] allows you to get widget metrics
in an instance of the [RenderData] class
and the difference between two [RenderData]
in an instance of the [ComparisonDiff] class