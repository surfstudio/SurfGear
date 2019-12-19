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
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:rxdart/rxdart.dart';

/// WidgetModel приложения
class AppWidgetModel extends SurfWidgetModel {
  final GlobalKey<NavigatorState> _navigator;

  AppWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
  ) : super(dependencies);

  @override
  void onLoad() {
    _loadApp();
    super.onLoad();
  }

  void _loadApp() async {
    subscribeHandleError(
      initApp(),
      (isAuth) {
        _openScreen(CounterScreenRoute());
      },
    );
  }

  Observable<bool> initApp() {
    /// имитация задержки на инициализацию приложения
    return Observable.just(true).delay(Duration(seconds: 2));
  }

  void _openScreen(PageRoute route) {
    _navigator.currentState.pushReplacement(route);
  }
}
