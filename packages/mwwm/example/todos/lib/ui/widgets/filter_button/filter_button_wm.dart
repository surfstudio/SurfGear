import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';
import 'package:todos/models/filter_type.dart';
import 'package:todos/modules/provider.dart';
import 'package:todos/repositories/todos_repository.dart';

class FilterButtonWM extends WidgetModel {
  final TodosRepository _todosRepository;

  FilterButtonWM(
    BuildContext context,
  )   : _todosRepository = context.read<AppProvider>().todosRepository,
        super(WidgetModelDependencies());

  StreamedState<FilterType> get currentFilterState => _todosRepository.currentFilterState;

  void selectFilter(FilterType filterType) {
    _todosRepository.setFilter(filterType);
  }
}
