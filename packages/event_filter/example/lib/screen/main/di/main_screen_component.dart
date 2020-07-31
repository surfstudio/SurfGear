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

import 'package:event_filter/event_filter.dart';
import 'package:example/error/standard_error_handler.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

/// [Component] for screen MainScreen
class MainScreenComponent implements Component {
  MainScreenComponent(BuildContext context) {
    navigator = Navigator.of(context);
    widgetModelDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        filter: DefaultErrorFilter(
          EventFilterStrategyFactory(
            <Type, EventFilterStrategy<ErrorEvent>>{},
            DefaultErrorFilterStrategy(),
          ),
        ),
        strategyProvider: DefaultErrorStrategyProvider(
          EventStrategyFactory(
            <Type, EventStrategy<ErrorEvent>>{},
            DefaultErrorStrategy(),
          ),
        ),
      ),
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  NavigatorState navigator;

  WidgetModelDependencies widgetModelDependencies;
}
