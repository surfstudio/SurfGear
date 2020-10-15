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
import 'package:counter/ui/app/app.dart';

/// WidgetModel for [App]
class AppWidgetModel {
  AppWidgetModel(
    this._navigator,
  ) {
    _loadApp();
  }

  final GlobalKey<NavigatorState> _navigator;

  Future<void> _loadApp() async {
    initApp().listen(
      (isAuth) {
        _openScreen(CounterScreenRoute());
      },
    );
  }

  void dispose() {}

  Stream<bool> initApp() {
    /// imitation of application initialization delay
    return Stream.value(true).delay(const Duration(seconds: 2));
  }

  void _openScreen(PageRoute route) {
    _navigator.currentState.pushReplacement<Object, Object>(route);
  }
}
