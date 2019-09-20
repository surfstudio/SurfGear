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

import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart' show NavigatorState;
import 'package:flutter/material.dart' as prefix1;
import 'package:mwwm/mwwm.dart';

/// WidgetModel для экрана счетчика
class CounterWidgetModel extends WidgetModel {
  final NavigatorState navigator;
  final prefix0.GlobalKey<prefix1.ScaffoldState> _controller;

  Action incrementAction = Action();

  StreamedState<int> counterState = StreamedState(0);

  CounterWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._controller,
  ) : super(dependencies);

  @override
  void onLoad() {
    _listenToActions();
    super.onLoad();
  }

  void _listenToActions() {
    bind(
      incrementAction,
      (_) => counterState.accept(counterState.value + 1),
    );

    bind(showInit, (_) => _controller.currentState.showSnackBar(
        prefix1.SnackBar(
          content: prefix1.Text('init'),
        ),
      ),);

    subscribe(
      counterState.stream.where((c) => c % 2 == 0).skip(1),
      (c) => _controller.currentState.showSnackBar(
        prefix1.SnackBar(
          content: prefix1.Text('Tabbed $c'),
        ),
      ),
    );
  }

  final showInit = Action();
}
