import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/repository/facts_repository.dart';

class FactsScreenWidgetModel extends WidgetModel {
  FactsScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
  ) : super(baseDependencies);

  final facts = StreamedState<Iterable<Fact>>([]);

  @override
  void onLoad() {
    super.onLoad();
    _fetchFacts();
  }

  void _fetchFacts() async {
    await facts.accept(await FactsRepository.getFacts());
  }
}

FactsScreenWidgetModel createFactsScreenWidgetModel(BuildContext context) =>
    FactsScreenWidgetModel(
      WidgetModelDependencies(),
    );
