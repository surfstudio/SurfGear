// Copyright (c) 2019-present, SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/interactor/facts/facts_interactor.dart';
import 'package:cat_facts/interactor/theme/theme_interactor.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class FactsScreenWidgetModel extends WidgetModel {
  final facts = StreamedState<Iterable<Fact>>([]);

  final ThemeInteractor _themeInteractor;
  final FactsInteractor _factsInteractor;

  FactsScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._themeInteractor,
    this._factsInteractor,
  ) : super(baseDependencies);

  @override
  void onLoad() {
    super.onLoad();
    _fetchFacts();
  }

  Stream<AppTheme?> currentTheme() => _themeInteractor.appTheme.stream;

  void switchTheme() => _themeInteractor.changeTheme();

  Future<void> _fetchFacts() async =>
      facts.accept(await _factsInteractor.getFacts(count: 5));

  Future<void> _fetchFact() async =>
      facts.accept(await _factsInteractor.getFact());

  void loadMoreFacts() {
    _fetchFact();
  }
}

FactsScreenWidgetModel createFactsScreenWidgetModel(BuildContext context) {
  return FactsScreenWidgetModel(
    const WidgetModelDependencies(),
    context.read<ThemeInteractor>(),
    context.read<FactsInteractor>(),
  );
}
