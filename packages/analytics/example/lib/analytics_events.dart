import 'package:example/firebase/firebase_analytic_event.dart';

class FantasticButtonTappedEvent implements FirebaseAnalyticEvent {
  @override
  String get key => 'fantastic_button_tapped';

  @override
  Map<String, dynamic> get params => null;

  @override
  String toString() => 'FantasticButtonTappedEvent';
}

class SparklingButtonTappedEvent implements FirebaseAnalyticEvent {
  SparklingButtonTappedEvent(this.payload);

  final String payload;

  @override
  String get key => 'sparkling_button_tapped';

  @override
  Map<String, String> get params => {
        'payload': payload,
      };

  @override
  String toString() => 'SparklingButtonTappedEvent';
}

class DelightfulButtonTappedEvent implements FirebaseAnalyticEvent {
  DelightfulButtonTappedEvent({this.isDelightful});

  final bool isDelightful;

  @override
  String get key => 'delightful_button_tapped';

  @override
  Map<String, bool> get params => {
        'isDelightful': isDelightful,
      };

  @override
  String toString() => 'DelightfulButtonTappedEvent';
}
