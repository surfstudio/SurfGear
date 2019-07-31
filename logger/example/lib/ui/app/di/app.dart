import 'package:counter/interactor/counter/counter_interactor.dart';
import 'package:counter/interactor/counter/repository/counter_repository.dart';
import 'package:counter/ui/app/app_wm.dart';
import 'package:counter/util/sp_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mwwm/mwwm.dart';

/// Component для приложения
class AppComponent implements BaseWidgetModelComponent<AppWidgetModel> {
  AppWidgetModel wm;

  final preferencesHelper = PreferencesHelper();
  CounterInteractor counterInteractor;

  AppComponent(Key navigatorKey) {
    Logger.d('call AppComponent constructor');
    counterInteractor = CounterInteractor(CounterRepository(preferencesHelper));

    wm = AppWidgetModel(
      WidgetModelDependencies(),
      navigatorKey,
    );
  }
}
