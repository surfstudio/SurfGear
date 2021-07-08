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
import 'package:cat_facts/ui/screen/facts/components/fact_list_tile.dart';
import 'package:cat_facts/ui/screen/facts/facts_screen_wm.dart';
import 'package:cat_facts/ui/screen/facts/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

@immutable
class FactsScreen extends CoreMwwmWidget<FactsScreenWidgetModel> {
  FactsScreen({
    Key? key,
  }) : super(
          key: key,
          widgetModelBuilder: (context) => createFactsScreenWidgetModel(
            context,
            _scaffoldKey,
          ),
        );

  @override
  WidgetState<CoreMwwmWidget<FactsScreenWidgetModel>, FactsScreenWidgetModel>
      createWidgetState() {
    return _FactsScreenState();
  }
}

class _FactsScreenState
    extends WidgetState<FactsScreen, FactsScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: const Text('More'),
        onPressed: () {
          wm.loadMoreFacts();
        },
      ),
      appBar: AppBar(
        title: const Text('Cats facts'),
        actions: [
          TextButton(
            key: const Key('theme_switcher'),
            onPressed: () {
              wm.switchTheme();
            },
            child: StreamBuilder<AppTheme?>(
              stream: wm.currentTheme(),
              builder: (context, snapshot) {
                return ThemeButton(theme: snapshot.data);
              },
            ),
          ),
        ],
      ),
      body: StreamedStateBuilder<Iterable<Fact>>(
        streamedState: wm.facts,
        builder: (context, facts) {
          if (facts != null && facts.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: facts.length,
                    itemBuilder: (c, i) {
                      final el = facts.elementAt(i);
                      return FactListTile(wm: wm, el: el, position: i + 1);
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Loaded ${facts.length} facts',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Total length ${wm.totalLength.value}'),
                ),
                const SizedBox(height: 20),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
