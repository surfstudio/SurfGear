// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:name_generator/domain/User.dart';
import 'package:name_generator/interactor/name_generator/name_generator_interactor.dart';
import 'package:rxdart/rxdart.dart';

/// WidgetModel для экрана счетчика
class NameGeneratorWidgetModel {
  List<User> _userList = [];

  final NameGeneratorInteractor _interactor;

  BehaviorSubject<bool> getUserAction = BehaviorSubject();
  BehaviorSubject<List<User>> listState = BehaviorSubject();

  NameGeneratorWidgetModel(
    this._interactor,
  ) {
    _listenToActions();
  }

  void _listenToActions() {
    listState.add([]);

    getUserAction.listen((_) {
      _interactor.getCard().listen((user) {
        _userList = listState.value;
        _userList.add(user);
        listState.add(_userList);
      });
    });
  }

  void dispose() {
    getUserAction.close();
    listState.close();
  }
}
