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

import 'dart:async';
import 'package:counter/ui/screen/counter/performer/performer.dart';
import 'package:flutter/material.dart' show NavigatorState;
import 'package:flutter/material.dart' as w;
import 'package:mwwm/mwwm.dart';

/// WidgetModel for counter screen
class CounterWidgetModel extends WidgetModel {
  final NavigatorState navigator;
  final w.GlobalKey<w.ScaffoldState> key;

  /// relations
  final counterState = StreamController<int>.broadcast();
  int currentCounter = 0;

  CounterWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this.key,
  ) : super(dependencies,
            model: Model([
              Incrementor(),
            ]));

  @override
  void onLoad() {
    _listenToStates();
    super.onLoad();
  }

  void incrementAction() {
    doFuture<int>(model.perform(Increment(1)), counterState.add);
    doFuture<int>(model.perform(Decrement(1)), counterState.add);
  }

  void _listenToStates() {
    subscribe(
      model.listen<Increment, int>().where((c) => c % 2 == 0).skip(1),
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
