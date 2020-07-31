// Copyright (c) 2019-present,  SurfStudio LLC
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

import 'package:counter/interactor/counter/counter_interactor.dart';
import 'package:counter/interactor/counter/repository/counter_repository.dart';
import 'package:counter/ui/app/app_wm.dart';
import 'package:counter/util/sp_helper.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

/// Component для приложения
class AppComponent implements Component {
  AppComponent(GlobalKey<NavigatorState> navigatorKey) {
    counterInteractor = CounterInteractor(CounterRepository(preferencesHelper));

    wm = AppWidgetModel(
      navigatorKey,
    );
  }

  AppWidgetModel wm;

  final preferencesHelper = PreferencesHelper();
  CounterInteractor counterInteractor;
}
