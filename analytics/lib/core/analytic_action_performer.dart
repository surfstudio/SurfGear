import 'package:analytics/core/analytic_action.dart';

/// Осуществляет выполнение действия в аналитике
abstract class AnalyticActionPerformer<A extends AnalyticAction> {
  /// Возвращает true, если выполнитель может обработать действие
  bool canHandle(AnalyticAction action);

  /// Выполнить действие
  void perform(A action);
}
