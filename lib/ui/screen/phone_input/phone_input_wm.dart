import 'package:flutter/widgets.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/base/action.dart';
import 'package:flutter_template/ui/base/dependency/widget_model_dependencies.dart';
import 'package:flutter_template/ui/base/entity_state.dart';
import 'package:flutter_template/ui/base/widget_model.dart';
import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/phone_number_util.dart';
import 'package:rxdart/rxdart.dart';

/// модель экрана авторизации
class PhoneInputWidgetModel extends WidgetModel {
  final CounterInteractor _counterInteractor;
  final NavigatorState navigator;

  BehaviorSubject<bool> buttonEnabledSubject = BehaviorSubject();
  BehaviorSubject<AuthState> phoneInputStateSubject = BehaviorSubject();
  BehaviorSubject<int> counterSubject = BehaviorSubject();

  Action<String> textChanges = Action();
  Action nextAction = Action();

  String _phoneNumber = EMPTY_STRING;

  PhoneInputWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._counterInteractor,
  ) : super(dependencies);

  @override
  void onLoad() {
    _listenToStreams();
  }

  void _listenToStreams() {
    _listenToActions();

    listenToStream<AuthState>(phoneInputStateSubject, (state) {
      buttonEnabledSubject.add(!state.isLoading);
    });

    listenToStream(
      _counterInteractor.counterObservable,
          (c) => counterSubject.add(c.count),
    );
  }

  void _listenToActions() {
    listenToStream<String>(textChanges.action, (s) {
      _phoneNumber = PhoneNumberUtil.normalize(s, withPrefix: true);
      buttonEnabledSubject.add(_phoneNumber.length >= PHONE_LENGTH);
    });

    listenToStream(
      nextAction.action,
      (_) {
        if (buttonEnabledSubject.value) {
          _counterInteractor.incrementCounter();
        }
      },
    );
  }

}

class AuthState extends EntityState<String> {
  AuthState.error() : super.error();

  AuthState.loading() : super.loading();

  AuthState.none([String data]) : super.none(data);
}
