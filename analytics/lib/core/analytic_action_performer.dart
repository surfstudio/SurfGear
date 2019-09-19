import 'package:analytics/core/analytic_action.dart';

/// A performer of specific actions used to incapsulate work with
/// a certain analytics service. Typically implemented by transforming
/// [AnalyticAction] into a required format as well as calling `send()`
/// of a third-party library.
abstract class AnalyticActionPerformer<A extends AnalyticAction> {
  bool canHandle(AnalyticAction action);
  void perform(A action);
}
