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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

import 'di/app.dart';

/// Билдер для [AppWidgetModel].
AppWidgetModel createAppWidgetModel(BuildContext context) {
  final component = Injector.of<AppComponent>(context).component;

  return AppWidgetModel(
    component.wmDependencies,
    component.messageController,
  );
}

/// [WidgetModel] для виджета приложения
class AppWidgetModel extends WidgetModel {
  AppWidgetModel(
    WidgetModelDependencies dependencies,
    this._msgController,
  ) : super(dependencies);

  // ignore: unused_field
  final MessageController _msgController;
}
