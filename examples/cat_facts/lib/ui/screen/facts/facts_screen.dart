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
import 'package:cat_facts/ui/screen/facts/facts_screen_wm.dart';
import 'package:cat_facts/ui/screen/facts/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

@immutable
class FactsScreen extends CoreMwwmWidget {
  const FactsScreen({
    Key? key,
  }) : super(key: key, widgetModelBuilder: createFactsScreenWidgetModel);

  @override
  State<StatefulWidget> createState() => _FactsSceenState();
}

class _FactsSceenState extends WidgetState<FactsScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cats facts'),
        actions: [
          TextButton(
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
            return ListView.builder(
              itemCount: facts.length,
              itemBuilder: (c, i) {
                final el = facts.elementAt(i);

                return ListTile(title: Text(el.text ?? ''));
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
