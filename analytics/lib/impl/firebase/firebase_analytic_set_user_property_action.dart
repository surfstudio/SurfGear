import 'package:analytics/analytics.dart';

/// Действие установки свойств пользователя для аналитики Firebase
class FirebaseAnalyticSetUserPropertyAction implements AnalyticAction {
  final String key;
  final String value;

  FirebaseAnalyticSetUserPropertyAction(this.key, this.value);
}
