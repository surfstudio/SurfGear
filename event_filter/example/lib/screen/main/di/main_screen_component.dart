import 'package:event_filter/event_filter.dart';
import 'package:example/error/standard_error_handler.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

/// [Component] for screen MainScreen
class MainScreenComponent implements Component {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  NavigatorState navigator;

  WidgetModelDependencies widgetModelDependencies;

  MainScreenComponent(BuildContext context) {
    navigator = Navigator.of(context);
    widgetModelDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        filter: DefaultErrorFilter(
          EventFilterStrategyFactory(
            Map<Type, EventFilterStrategy<ErrorEvent>>(),
            DefaultErrorFilterStrategy(),
          ),
        ),
        strategyProvider: DefaultErrorStrategyProvider(
          EventStrategyFactory(
            Map<Type, EventStrategy<ErrorEvent>>(),
            DefaultErrorStrategy(),
          ),
        ),
      ),
    );
  }
}