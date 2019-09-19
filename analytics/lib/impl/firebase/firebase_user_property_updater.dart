import 'package:analytics/core/analytic_action.dart';
import 'package:analytics/core/analytic_action_performer.dart';
import 'package:analytics/impl/firebase/const.dart';
import 'package:analytics/impl/firebase/firebase_user_property.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseUserPropertyUpdater
    implements AnalyticActionPerformer<FirebaseUserProperty> {
  final FirebaseAnalytics _firebaseAnalytics;

  FirebaseUserPropertyUpdater(this._firebaseAnalytics);

  @override
  bool canHandle(AnalyticAction action) => action is FirebaseUserProperty;

  @override
  void perform(FirebaseUserProperty action) {
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
