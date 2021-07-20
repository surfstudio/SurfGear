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
  final totalLength = StreamedState<int>(0);

  final ThemeInteractor _themeInteractor;
  final FactsInteractor _factsInteractor;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  FactsScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._themeInteractor,
    this._factsInteractor,
    this._scaffoldKey,
  ) : super(baseDependencies);

  @override
  void onLoad() {
    super.onLoad();
    _fetchListFacts();
  }

  Stream<AppTheme?> currentTheme() => _themeInteractor.appTheme.stream;

  void switchTheme() => _themeInteractor.changeTheme();

  void loadMoreFacts() => _fetchFact();

  Future<void> _fetchListFacts() async {
    final response = await _factsInteractor.getFacts(count: 1);
    await totalLength.accept(_countTotalLength(response));
    await facts.accept(response);
  }

  Future<void> _fetchFact() async {
    try {
      final response = await _factsInteractor.appendFact();
      await totalLength.accept(_countTotalLength(response));
      await facts.accept(response);
    } on Exception catch (_) {
      _scaffoldKey.currentState!.showSnackBar(const SnackBar(
        content: Text('An error occurred while trying to get a fact'),
      ));
    }
  }

  int _countTotalLength(Iterable<Fact> response) {
    var _totalLength = 0;
    for (final fact in response) {
      _totalLength = _totalLength + (fact.length ?? 0);
    }
    return _totalLength;
  }
}

FactsScreenWidgetModel createFactsScreenWidgetModel(
  BuildContext context,
  GlobalKey<ScaffoldState> _scaffoldKey,
) {
  return FactsScreenWidgetModel(
    const WidgetModelDependencies(),
    context.read<ThemeInteractor>(),
    context.read<FactsInteractor>(),
    _scaffoldKey,
  );
}
