import 'package:counter/ui/app/di/app.dart';
import 'package:counter/ui/screen/counter/counter_wm.dart';
import 'package:counter/ui/screen/counter/di/counter.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

/// Widget для экрана счетчика
class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState
    extends WidgetState<CounterScreen, CounterWidgetModel, CounterComponent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget buildState(BuildContext context) {
    return _buildScreen(context);
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      initialData: 0,
      builder: (context, snapshot) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              Text(
                '${snapshot.data}',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  CounterComponent getComponent(BuildContext context) {
    /// получение зависимостей
    return CounterComponent(
      Injector.of<AppComponent>(context).component,
      Navigator.of(context),
    );
  }
}
