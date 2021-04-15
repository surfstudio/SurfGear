import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:todos/models/filter_type.dart';
import 'package:todos/repositories/todos_repository.dart';

class FilterButtonWM extends WidgetModel {
  FilterButtonWM(
    this._todosRepository,
  ) : super(const WidgetModelDependencies());

  final TodosRepository _todosRepository;

  StreamedState<FilterType> get currentFilterState =>
      _todosRepository.currentFilterState;

  void selectFilter(FilterType filterType) {
    _todosRepository.setFilter(filterType);
  }
}
