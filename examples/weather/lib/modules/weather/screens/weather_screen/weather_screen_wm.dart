import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';

class WeatherScreenWidgetModel extends WidgetModel {
  WeatherScreenWidgetModel(WidgetModelDependencies baseDependencies)
      : super(baseDependencies);

  @override
  void onLoad() {
    // TODO: implement onLoad
    super.onLoad();
  }

  @override
  void onBind() {
    // TODO: implement onBind
    super.onBind();
  }
}

WeatherScreenWidgetModel createWeatherScreenWidgetModel(BuildContext context) {
  return WeatherScreenWidgetModel(
    const WidgetModelDependencies(),
  );
}
