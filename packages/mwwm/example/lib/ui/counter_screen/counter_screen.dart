import 'package:counter/ui/counter_screen/counter_wm.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';

/// Counter's screen
class CounterScreen extends CoreMwwmWidget<CounterWidgetModel> {
  const CounterScreen({
    required WidgetModelBuilder<CounterWidgetModel> widgetModelBuilder,
    Key? key,
  }) : super(key: key, widgetModelBuilder: widgetModelBuilder);

  @override
  WidgetState<CoreMwwmWidget<CounterWidgetModel>, CounterWidgetModel>
      createWidgetState() {
    return _CounterScreenState();
  }
}

class _CounterScreenState
    extends WidgetState<CounterScreen, CounterWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<CounterWidgetModel>(
          builder: (_, widgetModel, __) {
            return Text(
              '${widgetModel.counter}',
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: wm.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
