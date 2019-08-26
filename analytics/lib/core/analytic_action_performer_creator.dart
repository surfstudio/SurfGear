import 'package:analytics/core/analytic_action.dart';
import 'package:analytics/core/analytic_action_performer.dart';

/// Задает отображение действия в аналитике и списка сущностей которые выполнят действие
abstract class AnalyticActionPerformerCreator<A extends AnalyticAction> {
  /// Возвращает выполнители, которые могут обработать действие аналитики
  List<AnalyticActionPerformer> getPerformersByAction(A event);
}
