import 'package:analytics/impl/firebase/firebase_analytic_event.dart';

class FantasticButtonTappedEvent implements FirebaseAnalyticEvent {
  @override
  String get key => 'fantastic_button_tapped';

  @override
  Map<String, dynamic> get params => null;

  @override
  String toString() => 'FantasticButtonTappedEvent';
}

class SparklingButtonTappedEvent implements FirebaseAnalyticEvent {
  final String payload;

  SparklingButtonTappedEvent(this.payload);

  @override
  String get key => 'sparkling_button_tapped';

  @override
  Map<String, dynamic> get params => {
        'payload': payload,
      };

  @override
  String toString() => 'SparklingButtonTappedEvent';
}

class DelightfulButtonTappedEvent implements FirebaseAnalyticEvent {
  final bool isDelightful;

  DelightfulButtonTappedEvent(this.isDelightful);

  @override
  String get key => 'delightful_button_tapped';

  @override
  Map<String, dynamic> get params => {
        'isDelightful': isDelightful,
      };

  @override
  String toString() => 'DelightfulButtonTappedEvent';
}
