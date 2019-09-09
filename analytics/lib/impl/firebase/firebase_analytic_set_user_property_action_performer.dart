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

import 'package:analytics/core/analytic_action.dart';
import 'package:analytics/core/analytic_action_performer.dart';
import 'package:analytics/impl/firebase/const.dart';
import 'package:analytics/impl/firebase/firebase_analytic_set_user_property_action.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

/// Отправляет свойство пользователя в Firebase аналитику
class FirebaseAnalyticSetUserPropertyActionPerformer
    implements AnalyticActionPerformer<FirebaseAnalyticSetUserPropertyAction> {
  final FirebaseAnalytics _firebaseAnalytics;

  FirebaseAnalyticSetUserPropertyActionPerformer(this._firebaseAnalytics);

  @override
  bool canHandle(AnalyticAction action) =>
      action is FirebaseAnalyticSetUserPropertyAction;

  @override
  void perform(FirebaseAnalyticSetUserPropertyAction action) {
    _firebaseAnalytics.setUserProperty(
      name: _cutName(action.key),
      value: _cutValue(action.value),
    );
  }

  String _cutName(String name) =>
      name.length <= MAX_SET_USER_PROPERTY_KEY_LENGTH
          ? name
          : name.substring(0, MAX_SET_USER_PROPERTY_KEY_LENGTH);

  String _cutValue(String value) =>
      value.length <= MAX_SET_USER_PROPERTY_VALUE_LENGTH
          ? value
          : value.substring(0, MAX_SET_USER_PROPERTY_VALUE_LENGTH);
}
