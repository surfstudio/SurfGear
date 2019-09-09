/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/util/const.dart';
import 'package:flutter_template/util/phone_number_util.dart';
import 'package:mwwm/mwwm.dart';

/// модель экрана авторизации
class PhoneInputWidgetModel extends WidgetModel {
  final CounterInteractor _counterInteractor;
  final widgets.NavigatorState navigator;

  StreamedState<bool> buttonEnabledState = StreamedState();
  EntityStreamedState<String> phoneInputState = EntityStreamedState();
  StreamedState<int> counterState = StreamedState();

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
    super.onLoad();
    _listenToStreams();
  }

  void _listenToStreams() {
    _listenToActions();

    bind<EntityState<String>>(
      phoneInputState,
      (state) {
        buttonEnabledState.accept(!state.isLoading);
      },
    );

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
