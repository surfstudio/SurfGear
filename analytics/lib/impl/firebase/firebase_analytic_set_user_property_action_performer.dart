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
