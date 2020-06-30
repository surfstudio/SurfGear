import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:relation/relation.dart' as r;

class DemoRelations extends StatefulWidget {
  @override
  _DemoRelationsState createState() => _DemoRelationsState();
}

class _DemoRelationsState extends State<DemoRelations> {
  final incrementAction = r.Action();
  final incrementState = r.StreamedState<int>(0);

  final reloadAction = r.Action();
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
    var result = Future.delayed(
      Duration(seconds: 2),
      () => DateTime.now().second,
    );
    await loadDataState.content(await result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo for relations'),
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
            r.StreamedStateBuilder(
              streamedState: incrementState,
              builder: (ctx, count) => Text('number of count: $count'),
            ),

            const SizedBox(width: 32.0),

            /// button for increment
            FlatButton(
              onPressed: incrementAction,
              color: Colors.red,
              child: Text('increment'),
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
            loadingChild: CircularProgressIndicator(),
            errorChild: Text('sorry - error, try again'),
          ),

          const SizedBox(width: 32.0),

          /// button for increment
          FlatButton(
            onPressed: reloadAction,
            color: Colors.red,
            child: Text('reload'),
          ),
        ],
      ),
    );
  }
}
