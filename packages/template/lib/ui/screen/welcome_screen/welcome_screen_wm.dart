import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/screen/welcome_screen/di/welcome_screen_component.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_mwwm/surf_mwwm.dart' as m;
import 'package:surf_mwwm/surf_mwwm.dart';

/// Билдер для [WelcomeScreenWidgetModel].
WelcomeScreenWidgetModel createWelcomeWidgetModel(BuildContext context) {
  var component = Injector.of<WelcomeScreenComponent>(context).component;

  return WelcomeScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.counterInteractor,
  );
}

/// [WidgetModel] для экрана <Welcome>
class WelcomeScreenWidgetModel extends WidgetModel {
  final CounterInteractor _counterInteractor;
  final widgets.NavigatorState navigator;

  StreamedState<int> counterState = StreamedState();

  m.Action nextAction = m.Action();

  WelcomeScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._counterInteractor,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
    _listenToStreams();
  }

  void _listenToStreams() {
    _listenToActions();

    subscribe(
      _counterInteractor.counterObservable,
      (c) => counterState.accept(c.count),
    );
  }

  void _listenToActions() {
    bind(
      nextAction,
      (_) {
        _counterInteractor.incrementCounter();
      },
    );
  }
}