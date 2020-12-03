# Render Metrics
[![Pub Version](https://img.shields.io/pub/v/render_metrics)](https://pub.dev/packages/render_metrics)
[![Pub Version (including pre-releases)](https://img.shields.io/pub/v/render_metrics?include_prereleases)](https://pub.dev/packages/render_metrics)
[![Pub Likes](https://badgen.net/pub/likes/render_metrics)](https://pub.dev/packages/render_metrics)

This package is a part of [SurfGear](https://github.com/surfstudio/SurfGear) toolset made by [Surf](https://surf.ru/).

[![SurfGear](https://i.ibb.co/ySbGgP9/logo.png)](https://github.com/surfstudio/SurfGear)

## About
This package helps retrieve the current positioning coordinates of any widget in a widgets tree in your Flutter application.

## Currently supported features

- Retrieve the full set of positioning coordinates of the desired widget at any time;
- Calculate the difference in positioning between two widgets and use it the way you need.

## Usage

### Getting widget's coordinates

Instantiate `RenderParametersManager` object. You can set a special type for the widget's unique identifier or leave it `dynamic`.

```dart
final renderManager = RenderParametersManager<dynamic>();
```

Wrap the desired widget in a `RenderMetricsObject`. The `id` parameter is the widget’s unique identifier.

```dart
RenderMetricsObject(
    id: "uniqueWidgetId",
    manager: renderManager,
    child: Container(
        ...
    ),
),
```

Get a bundle with the positioning coordinates of the wrapped widget.

```dart
RenderData data = renderManager.getRenderData("uniqueWidgetId");
```

### Calculating the difference in positioning between two widgets

Wrap the widgets you want to compare in `RenderMetricsObject`s. Specify two different `id`s for each of them. Please note, that the `manager` parameter of both widgets should contain the link to the same `RenderParametersManager` instance.

```dart
RenderMetricsObject(
    id: "rowWidgetId",
    manager: renderManager,
    child: Row(
        ...
    ),
),
RenderMetricsObject(
    id: "columnWidgetId",
    manager: renderManager,
    child: Column(
        ...
    ),
),
```

Specify two unique widget identifiers when using the `getDiffById()` function and extract a bundle with the relative difference in positioning coordinates between the widgets.

```dart
ComparisonDiff diff =
    renderManager.getDiffById("rowWidgetId", "columnWidgetId");
```

## What metrics can I get?

### RenderData

`RenderData` instance contains a complete set of properties that characterize any widget in a two-dimensional space.

All metrics positioning coordinates are global, meaning they are relative to the entire screen coordinate space.

<img src="https://i.ibb.co/Jkczrmg/Group-20.png" alt="RenderData" width="300"/>

`RenderData` also provides you an ability to get all widget keypoint XY-coordinates by calling one of special getters.

<img src="https://i.ibb.co/QQbP0rm/2020-12-03-10-01-29.png" alt="RenderData" width="300"/>

### ComparisonDiff

You can get the comparison relative results for each widget keypoint from the `ComparisonDiff` instance.

An additional set of special getters can help you calculate the difference between two adjacent sides of two different widgets (e.g. right to left, top to bottom, etc.).

<img src="https://i.ibb.co/MC68wTT/Group-12.png" alt="RenderData" width="300"/>

## Installation

Add Render Metrics to your `pubspec.yaml` file:

```yaml
dependencies:
  render_metrics: version
```

You can use both `stable` and `dev` versions of the package listed above in the badges bar.

## Changelog

All significant changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues
Please report any issues directly to the [main SurfGear repo](https://github.com/surfstudio/SurfGear).

## Contribute
If you would like to contribute to the package (such as by improving the documentation, solving a bug, or adding a cool new feature), please address our [contribution guide](../../CONTRIBUTING.md) first and send us your pull request.

Your help is always appreciated.
## How to reach us

Please, feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)

