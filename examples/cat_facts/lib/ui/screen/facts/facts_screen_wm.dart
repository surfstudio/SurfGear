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

  Stream<AppTheme?> currentTheme() => _appStorage.appTheme.stream;
}

FactsScreenWidgetModel createFactsScreenWidgetModel(BuildContext context) {
  final appStorage = context.read<AppStorage>();

  return FactsScreenWidgetModel(
    const WidgetModelDependencies(),
    appStorage,
    FactsRepository(appStorage.apiClient),
  );
}
