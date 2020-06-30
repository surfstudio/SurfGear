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

import 'package:example/screen/main/di/main_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:surf_mwwm/surf_mwwm.dart' as m;

MainScreenWidgetModel createMainScreenWidgetModel(BuildContext context) {
  var component = Injector.of<MainScreenComponent>(context).component;

  return MainScreenWidgetModel(
    component.widgetModelDependencies,
    component.navigator,
  );
}

/// [WidgetModel] для экрана MainScreen
class MainScreenWidgetModel extends WidgetModel {
  final NavigatorState navigator;

  final m.Action nextAction = m.Action();

  MainScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
  ) : super(dependencies);

  @override
  void onLoad() {
    _listenToActions();

    super.onLoad();
  }

  void _listenToActions() {
    bind(
      nextAction,
      (_) {
        subscribeHandleError(
          Stream.error(Exception("Failed Increment")),
          (_) {},
        );
      },
    );
  }
}
