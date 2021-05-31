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

import 'package:counter/ui/screen/counter/counter_route.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// WidgetModel приложения
class AppWidgetModel extends WidgetModel {
  AppWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
  ) : super(dependencies);

  final GlobalKey<NavigatorState> _navigator;

  @override
  void onLoad() {
    _loadApp();
    super.onLoad();
  }

  Future<void> _loadApp() async {
    initApp().listenCatchError(this, onValue: (isAuth) {
      _openScreen(CounterScreenRoute());
    });
  }

  Stream<bool> initApp() {
    /// имитация задержки на инициализацию приложения
    return Stream.value(true).delay(const Duration(seconds: 2));
  }

  void _openScreen(PageRoute<void> route) {
    _navigator.currentState?.pushReplacement(route);
  }
}
