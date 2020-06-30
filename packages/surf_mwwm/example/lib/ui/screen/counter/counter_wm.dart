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
import 'package:flutter/material.dart' show NavigatorState;
import 'package:flutter/material.dart' as w;
import 'package:surf_mwwm/surf_mwwm.dart';

/// WidgetModel для экрана счетчика
class CounterWidgetModel extends WidgetModel {
  final NavigatorState navigator;
  final w.GlobalKey<w.ScaffoldState> _key;
  final CounterScreenParams params;

  StreamedState<int> counterState = StreamedState(0);

  Action incrementAction = Action();
  final showInit = Action();

  CounterWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._key,
    this.params,
  ) : super(dependencies);

  @override
  void onLoad() {
    _listenToActions();
    super.onLoad();

    print('${params.argument1} + ${params.argument2}');
  }

  void _listenToActions() {
    subscribe(
      incrementAction.stream,
      (_) => counterState.accept(counterState.value + 1),
    );

    subscribe(
      showInit.stream,
      (_) => _key.currentState.showSnackBar(
        w.SnackBar(
          content: w.Text('init'),
        ),
      ),
    );

    subscribe(
      counterState.stream.where((c) => c % 2 == 0).skip(1),
      (c) {
        navigator.push(
          w.MaterialPageRoute(
            builder: (ctx) => w.Scaffold(
              body: w.Column(
                children: [
                  w.TextField(
                    autofocus: true,
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
