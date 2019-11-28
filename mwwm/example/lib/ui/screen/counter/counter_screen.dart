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

import 'package:counter/ui/screen/counter/counter_wm.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

/// Widget для экрана счетчика
class CounterScreen extends CoreMwwmWidget {
  CounterScreen()
      : super(
          widgetModelBuilder: (BuildContext context) => CounterWidgetModel(
            WidgetModelDependencies(),
            Navigator.of(context),
            GlobalKey(),
          ),
          widgetStateBuilder: () => _CounterScreenState(),
        );
}

class _CounterScreenState extends WidgetState<CounterWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: wm.key,
      appBar: AppBar(
        title: Text('Counter Demo'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: wm.incrementAction,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<int>(
      stream: wm.counterState.stream,
      initialData: wm.currentCounter,
      builder: (context, snapshot) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the this many times:'),
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
    );
  }
}
