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
import 'package:event_filter/src/event/event.dart';
import 'package:event_filter/src/strategy/base_event_strategy.dart';
import 'package:flutter/material.dart';

/// Factory of strategy.
abstract class BaseStrategyFactory<T extends BaseEventStrategy> {
  @protected
  final Map<Type, T> strategies;

  @protected
  final T defaultStrategy;

  BaseStrategyFactory(
    this.strategies,
    this.defaultStrategy,
  );

  T findStrategy(Event event) {
    var eventType = event.runtimeType;

    if (strategies.containsKey(eventType)) {
      return strategies[eventType];
    }

    return defaultStrategy;
  }
}
