import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/screen/welcome_screen/di/welcome_screen_component.dart';
import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/phone_number_util.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/mwwm.dart' as m;

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

  StreamedState<bool> buttonEnabledState = StreamedState();
  EntityStreamedState<String> phoneInputState = EntityStreamedState();
  StreamedState<int> counterState = StreamedState();

  m.Action<String> textChanges = m.Action();
  m.Action nextAction = m.Action();

  String _phoneNumber = EMPTY_STRING;

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

    phoneInputState.accept(EntityState.content(_phoneNumber));

    bind(phoneInputState, (state) {
      buttonEnabledState.accept(!state.isLoading);
    });

    subscribe(
      _counterInteractor.counterObservable,
      (c) => counterState.accept(c.count),
    );
  }

  void _listenToActions() {
    bind<String>(
      textChanges,
      (s) {
        _phoneNumber = PhoneNumberUtil.normalize(s, withPrefix: true);
        buttonEnabledState.accept(_phoneNumber.length >= PHONE_LENGTH);
      },
    );

    bind(
      nextAction,
      (_) {
        if (buttonEnabledState.value) {
          _counterInteractor.incrementCounter();
        }
      },
    );
  }
}
