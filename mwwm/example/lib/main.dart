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

import 'package:counter/ui/app/app.dart';
import 'package:counter/ui/app/app_wm.dart';
import 'package:counter/ui/app/di/app.dart';
import 'package:counter/ui/screen/counter/counter_wm.dart';
import 'package:counter/ui/screen/counter/di/counter.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:injector/injector.dart';

AppWidgetModel createAppModel(BuildContext context) => AppWidgetModel(
      WidgetModelDependencies(),
      Injector.of<AppComponent>(context).component.navigatorKey,
    );

CounterWidgetModel createCounterModel(BuildContext context) =>
    CounterWidgetModel(
      WidgetModelDependencies(),
      Injector.of<CounterComponent>(context).component.navigator,
      Injector.of<CounterComponent>(context).component.scaffoldKey,
    );

void main() {
  WidgetModelFactory.instance()
    ..registerBuilder<AppWidgetModel>(createAppModel)
    ..registerBuilder<CounterWidgetModel>(createCounterModel);

  runApp(App());
}
