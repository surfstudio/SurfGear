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

// import 'package:flutter/material.dart' show NavigatorState;
// import 'package:flutter/material.dart' as w;
// import 'package:flutter/material.dart' hide Action;
// import 'package:surf_mwwm/surf_mwwm.dart';

import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';

/// WidgetModel для экрана счетчика
class CounterWidgetModel extends WidgetModel {
  CounterWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._key,
  ) : super(dependencies);

  final NavigatorState navigator;
  final GlobalKey<ScaffoldState> _key;

  StreamedState<int> counterState = StreamedState(0);

  final incrementAction = VoidAction();
  final showInit = StreamedAction<int>();

  @override
  void onLoad() {
    _listenToActions();
    super.onLoad();
  }

  void _listenToActions() {
    incrementAction.bind((_) {
      counterState.accept(counterState.value + 1);
    }).listenOn(
      this,
      onValue: (_) {},
    );

    showInit.bind((_) {
      ScaffoldMessenger.of(_key.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('init'),
        ),
      );
    }).listenOn(this, onValue: (_) {});

    counterState.stream.where((c) => c.isEven).skip(1).listenOn(
      this,
      onValue: (c) {
        navigator.push(
          MaterialPageRoute<void>(
            builder: (ctx) => Scaffold(
              body: Column(
                children: [
                  TextField(
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
