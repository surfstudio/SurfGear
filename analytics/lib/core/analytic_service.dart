import 'package:analytics/analytics.dart';

/// Ответсвенен за выполнение действия аналитики.
abstract class AnalyticService<A extends AnalyticAction> {
  void performAction(A action);
}
