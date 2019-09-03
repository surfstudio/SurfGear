import 'package:analytics/core/analytic_action.dart';
import 'package:analytics/core/analytic_action_performer.dart';
import 'package:analytics/core/analytic_action_performer_creator.dart';
import 'package:analytics/core/analytic_service.dart';
import 'package:logger/logger.dart';

/// Реализация сервиса аналитики по умолчанию.
class DefaultAnalyticService
    implements
        AnalyticActionPerformerCreator<AnalyticAction>,
        AnalyticService<AnalyticAction> {
  final _performers = Set<AnalyticActionPerformer<AnalyticAction>>();

  @override
  void performAction(AnalyticAction action) {
    getPerformersByAction(action)
        .forEach((performer) => performer.perform(action));
  }

  @override
  List<AnalyticActionPerformer<AnalyticAction>> getPerformersByAction(
      AnalyticAction event) {
    final properPerformers =
        _performers.where((performer) => performer.canHandle(event)).toList();
    if (properPerformers.isEmpty) {
      Logger.d(
          "No action performer for action: ${event.runtimeType} in performers $_performers");
    }

    return properPerformers;
  }

  /// Добавить выполнитель действия
  DefaultAnalyticService addActionPerformer(
      AnalyticActionPerformer<AnalyticAction> performer) {
    _performers.add(performer);
    return this;
  }
}
