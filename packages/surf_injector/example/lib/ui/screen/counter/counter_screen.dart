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

import 'package:counter/ui/app/di/app.dart';
import 'package:counter/ui/screen/counter/counter_wm.dart';
import 'package:counter/ui/screen/counter/di/counter.dart';
import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';

/// Widget для экрана счетчика
class CounterScreen extends StatefulWidget {
  const CounterScreen({Key key}) : super(key: key);

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CounterWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return Injector<CounterComponent>(
      component: CounterComponent(
        Injector.of<AppComponent>(context).component,
        Navigator.of(context),
      ),
      builder: (context) {
        wm = Injector.of<CounterComponent>(context).component.wm;
        return _buildState(context);
      },
    );
  }

  Widget _buildState(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Counter Demo'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          wm.incrementAction.add(true);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<int>(
      stream: wm.counterState.stream,
      initialData: 0,
      builder: (context, snapshot) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                '${snapshot.data}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
