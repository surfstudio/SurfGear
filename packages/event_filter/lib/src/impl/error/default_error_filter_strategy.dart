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
import 'package:event_filter/src/impl/error/error_event.dart';

/// Default strategy of filtering error event
class DefaultErrorFilterStrategy extends EventFilterStrategy<ErrorEvent> {
  ErrorEvent? _currentEvent;

  @override
  ErrorEvent? filter(ErrorEvent? event) {
    if (_currentEvent == null) {
      _updateCurrent(event);

      return event;
    } else {
      final currentError = _currentEvent!.data;
      if (event != null) {
        final newError = event.data;

        if (currentError.runtimeType != newError.runtimeType) {
          _updateCurrent(event);

          return event;
        } else {
          return null;
        }
      } else {
        _updateCurrent(event);
        return event;
      }
    }
  }

  void _updateCurrent(ErrorEvent? event) {
    _currentEvent = event;

    Future<void>.delayed(const Duration(seconds: 4)).then((_) {
      if (_currentEvent == event) {
        _currentEvent = null;
      }
    });
  }
}
