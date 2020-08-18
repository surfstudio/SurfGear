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
import 'package:flutter/cupertino.dart';

/// The strategy of event processing.
abstract class EventStrategy<E extends Event<dynamic>>
    extends BaseEventStrategy<E> {
  EventStrategy({this.filterStrategy});

  final EventFilterStrategy<E> filterStrategy;

  /// Resolve event by selected strategy.
  void resolve(E event) {
    _resolve(event, filterStrategy);
  }

  /// Resolve event by selected strategy if it passed through transmitted
  /// filter.
  void resolveWithCurrentFilter(
    E event, {
    EventFilterStrategy<E> filter,
  }) {
    _resolve(event, filter);
  }

  @protected
  void doResolve(E event);

  void _resolve(E event, EventFilterStrategy<E> filter) {
    if (filter != null) {
      // ignore: parameter_assignments
      event = filter.filter(event);
    }

    if (event != null) {
      doResolve(event);
    }
  }
}
