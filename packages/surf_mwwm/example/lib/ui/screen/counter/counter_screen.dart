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

import 'package:counter/main.dart';
import 'package:counter/ui/screen/counter/counter_wm.dart';
import 'package:counter/ui/screen/counter/di/counter.dart';
import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Widget для экрана счетчика
class CounterScreen extends MwwmWidget<CounterComponent> {
  CounterScreen({Key? key})
      : super(
          key: key,
          dependenciesBuilder: (context) =>
              CounterComponent(Navigator.of(context)),
          widgetStateBuilder: () => _CounterScreenState(),
          widgetModelBuilder: createCounterModel,
        );
}

class _CounterScreenState extends OldWidgetState<CounterWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.getComponent<CounterComponent>().scaffoldKey,
      appBar: AppBar(
        title: const Text('Counter Demo'),
      ),
      body: StreamBuilder(
        stream: wm.counterState.stream,
        initialData: 0,
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You have pushed the this many times:'),
                Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.caption,
                ),
                TextField(
                  autofocus: true,
                  onChanged: (_) {},
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: wm.incrementAction,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
