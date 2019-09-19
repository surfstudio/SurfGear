import 'package:analytics/analytics.dart';

/// A unified entry point for several [AnalyticActionPerformer]s.
abstract class AnalyticService<A extends AnalyticAction> {
  void performAction(A action);
}
