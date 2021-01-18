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
import 'package:event_filter/src/factory/event_strategy_factory.dart';
import 'package:flutter/material.dart';

/// Provider of strategy for resolve event.
abstract class EventStrategyProvider {
  EventStrategyProvider(this.factory);

  @protected
  final EventStrategyFactory factory;

  /// Resolve strategy for event.
  void resolve(Event event) {
    factory.findStrategy(event)?.resolve(event);
  }

  /// Resolve strategy for event with transmitted filter.
  void resolveWithCurrentFilter(
    Event event, {
    EventFilterStrategy? filter,
  }) {
    factory.findStrategy(event)?.resolveWithCurrentFilter(event, filter: filter);
  }
}
