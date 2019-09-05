import 'package:analytics/analytics.dart';

/// Событие Firebase аналитики
abstract class FirebaseAnalyticEvent
    implements AnalyticAction, HasKey, HasMapParams {}
