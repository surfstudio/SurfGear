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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:relation/relation.dart' as r;

class DemoRelations extends StatefulWidget {
  const DemoRelations({Key key}) : super(key: key);

  @override
  _DemoRelationsState createState() => _DemoRelationsState();
}

class _DemoRelationsState extends State<DemoRelations> {
  final incrementAction = r.Action<void>();
  final incrementState = r.StreamedState<int>(0);

  final reloadAction = r.Action<void>();
  final loadDataState = r.EntityStreamedState<int>();

  @override
  void initState() {
    super.initState();
    incrementAction.stream.listen(
      (_) => incrementState.accept(incrementState.value + 1),
    );

    reloadAction.stream.listen((_) => _load());
  }

  Future _load() async {
    await loadDataState.loading();
    final result = Future.delayed(
      const Duration(seconds: 2),
      () => DateTime.now().second,
    );
    await loadDataState.content(await result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo for relations'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildDemo(),
            ),
            Expanded(
              child: _buildEntityDemo(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    incrementState.dispose();
    loadDataState.dispose();
    super.dispose();
  }

  Widget _buildDemo() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// build state by StreamedState
            r.StreamedStateBuilder<int>(
              streamedState: incrementState,
              builder: (ctx, count) => Text('number of count: $count'),
            ),

            const SizedBox(width: 32.0),

            /// button for increment
            FlatButton(
              onPressed: incrementAction,
              color: Colors.red,
              child: const Text('increment'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntityDemo() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// build state by StreamedState
          r.EntityStateBuilder<int>(
            streamedState: loadDataState,
            child: (ctx, data) => Text('success load: $data'),
            loadingChild: const CircularProgressIndicator(),
            errorChild: const Text('sorry - error, try again'),
          ),

          const SizedBox(width: 32.0),

          /// button for increment
          FlatButton(
            onPressed: reloadAction,
            color: Colors.red,
            child: const Text('reload'),
          ),
        ],
      ),
    );
  }
}
