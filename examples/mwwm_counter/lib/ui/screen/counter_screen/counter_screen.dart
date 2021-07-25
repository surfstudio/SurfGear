import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:mwwm/mwwm.dart';
import 'counter_screen_wm.dart';

// * Класс экрана наследует CoreMwwmWidget и типизируется WidgetMoldel-ю
@immutable
class CounterScreen extends CoreMwwmWidget<CounterScreenWidgetModel> {
  CounterScreen({Key? key})
      : super(
          key: key,
          widgetModelBuilder: (context) =>
              createCounterScreenWidgetModel(context),
        );

  // * основу можно создать в IDE по клику на create 1 missing ovveride
  @override
  WidgetState<CoreMwwmWidget<CounterScreenWidgetModel>,
      CounterScreenWidgetModel> createWidgetState() {
    return _CounterScreenState();
  }
}

class _CounterScreenState
    extends WidgetState<CounterScreen, CounterScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MWWM demo counter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            // * Билдер принимает StreamedState из WidgetModel через wm.переменная
            StreamedStateBuilder(
                streamedState: wm.counter,
                builder: (context, snapshot) {
                  return Text(
                    "$snapshot",
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // * обратиться к функции в WidgetModel также можно через wm.функция
          wm.incrementCounter();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
