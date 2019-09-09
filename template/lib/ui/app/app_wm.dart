/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/widgets.dart';
import 'package:flutter_template/ui/app/app.dart';
import 'package:mwwm/mwwm.dart';
import 'package:rxdart/rxdart.dart';

class AppWidgetModel extends WidgetModel {
  final GlobalKey<NavigatorState> _navigator;

  // ignore: unused_field
  final MessageController _msgController;

  AppWidgetModel(
    WidgetModelDependencies dependencies,
    this._msgController,
    this._navigator,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
    _loadApp();
  }

  void _loadApp() async {
    subscribeHandleError(
      initApp(),
      (isAuth) {
        _openScreen(Router.ROOT);
      },
    );
  }

  void _openScreen(String routeName) {
    _navigator.currentState.pushReplacementNamed(routeName);
  }

  Observable<bool> initApp() {
    return Observable.just(true).delay(Duration(seconds: 2));
  }
}
