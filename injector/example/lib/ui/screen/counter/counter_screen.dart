import 'package:counter/ui/app/di/app.dart';
import 'package:counter/ui/screen/counter/counter_wm.dart';
import 'package:counter/ui/screen/counter/di/counter.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

/// Widget для экрана счетчика
class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
        title: Text('Counter Demo'),
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
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
