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

import 'package:flutter/widgets.dart' hide Action;
import 'package:flutter_template/domain/counter.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/screen/welcome_screen/di/welcome_screen_component.dart';
import 'package:injector/injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Билдер для [WelcomeScreenWidgetModel].
WelcomeScreenWidgetModel createWelcomeWidgetModel(BuildContext context) {
  final component = Injector.of<WelcomeScreenComponent>(context).component;

  return WelcomeScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.counterInteractor,
  );
}

/// [WidgetModel] для экрана <Welcome>
class WelcomeScreenWidgetModel extends WidgetModel {
  WelcomeScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._counterInteractor,
  ) : super(dependencies);

  final CounterInteractor _counterInteractor;
  final NavigatorState navigator;

  StreamedState<int> counterState = StreamedState();

  Action nextAction = Action<void>();

  @override
  void onLoad() {
    super.onLoad();
    _listenToStreams();
  }

  void _listenToStreams() {
    _listenToActions();

    subscribe<Counter>(
      _counterInteractor.counterObservable,
      (c) => counterState.accept(c.count),
    );
  }

  void _listenToActions() {
    bind<void>(
      nextAction,
      (_) {
        _counterInteractor.incrementCounter();
      },
    );
  }
}
