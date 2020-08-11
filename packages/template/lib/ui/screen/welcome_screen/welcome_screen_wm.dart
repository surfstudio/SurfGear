import 'package:flutter/widgets.dart' hide Action;
import 'package:flutter_template/domain/counter.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/screen/welcome_screen/di/welcome_screen_component.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Билдер для [WelcomeScreenWidgetModel].
WelcomeScreenWidgetModel createWelcomeWidgetModel(BuildContext context) {
  final component = Injector.of<WelcomeScreenComponent>(context).component;

  return WelcomeScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.counterInteractor,
  );
}

/// [WidgetModel] для экрана <Welcome>
class WelcomeScreenWidgetModel extends WidgetModel {
  WelcomeScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._counterInteractor,
  ) : super(dependencies);

  final CounterInteractor _counterInteractor;
  final NavigatorState navigator;

  StreamedState<int> counterState = StreamedState();

  Action nextAction = Action<void>();

  @override
  void onLoad() {
    super.onLoad();
    _listenToStreams();
  }

  void _listenToStreams() {
    _listenToActions();

    subscribe<Counter>(
      _counterInteractor.counterObservable,
      (c) => counterState.accept(c.count),
    );
  }

  void _listenToActions() {
    bind<void>(
      nextAction,
      (_) {
        _counterInteractor.incrementCounter();
      },
    );
  }
}
