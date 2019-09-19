import 'package:analytics/analytics.dart';

class FirebaseUserProperty implements AnalyticAction {
  final String key;
  final String value;

  FirebaseUserProperty(this.key, this.value);
}
