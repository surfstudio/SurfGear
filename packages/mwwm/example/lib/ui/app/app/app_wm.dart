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
import 'package:mwwm/mwwm.dart';

/// WidgetModel for app
class AppWidgetModel extends WidgetModel {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  AppWidgetModel(
    WidgetModelDependencies dependencies,
  ) : super(dependencies, model: Model(const []));

  @override
  void onLoad() {
    super.onLoad();
    _loadApp();
  }

  void _loadApp() async {
    subscribeHandleError(
      initApp(),
      (isAuth) {
        _openScreen(CounterScreenRoute());
      },
    );
  }

  Stream<bool> initApp() {
    return Stream.fromFuture(
      Future.delayed(
        Duration(seconds: 2),
        () => true,
      ),
    );
  }

  void _openScreen(PageRoute route) {
    navigatorKey.currentState.pushReplacement(route);
  }
}
