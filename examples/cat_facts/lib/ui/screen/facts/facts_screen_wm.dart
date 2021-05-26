import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/repository/facts_repository.dart';
import 'package:cat_facts/storage/app/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class FactsScreenWidgetModel extends WidgetModel {
  FactsScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._appStorage,
    this._factsRepository,
  ) : super(baseDependencies);
  final AppStorage _appStorage;
  final FactsRepository _factsRepository;

  final facts = StreamedState<Iterable<Fact>>([]);

  @override
  void onLoad() {
    super.onLoad();
    _fetchFacts();
  }

  Future<void> _fetchFacts() async =>
      facts.accept(await _factsRepository.getFacts());

  void switchTheme() => _appStorage.changeTheme();
}

FactsScreenWidgetModel createFactsScreenWidgetModel(BuildContext context) {
  final appStorage = context.read<AppStorage>();

  return FactsScreenWidgetModel(
    const WidgetModelDependencies(),
    appStorage,
    FactsRepository(appStorage.apiClient),
  );
}
