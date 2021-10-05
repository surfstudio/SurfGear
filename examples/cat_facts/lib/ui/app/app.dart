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

import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/ui/app/app_localizations.dart';
import 'package:cat_facts/ui/app/app_localizations_delegate.dart';
import 'package:cat_facts/ui/app/app_wm.dart';
import 'package:cat_facts/ui/screen/facts/facts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

class App extends CoreMwwmWidget<AppWidgetModel> {
  const App({
    Key? key,
  }) : super(
          key: key,
          widgetModelBuilder: createAppWidgetModel,
        );

  @override
  WidgetState<CoreMwwmWidget<AppWidgetModel>, AppWidgetModel>
      createWidgetState() {
    return _AppState();
  }
}

class _AppState extends WidgetState<App, AppWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<AppTheme>(
      streamedState: wm.theme,
      builder: (context, theme) => MaterialApp(
        title: 'Cat Facts',
        theme: ThemeData(
          primaryColor: Colors.blue,
          fontFamily: 'Roboto',
        ),
        darkTheme: ThemeData.dark(),
        themeMode: theme == AppTheme.dark ? ThemeMode.dark : ThemeMode.light,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: FactsScreen(),
      ),
    );
  }
}
