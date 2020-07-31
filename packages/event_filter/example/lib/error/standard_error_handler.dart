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
import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';

/// Standard error handler.
class StandardErrorHandler extends ErrorHandler {
  StandardErrorHandler({
    @required this.strategyProvider,
    this.filter,
  });

  final EventFilter filter;
  final EventStrategyProvider strategyProvider;

  @override
  void handleError(Object e) {
    ErrorEvent event = ErrorEvent(e as Exception);

    /// filtering if filter was set
    if (filter != null) {
      event = filter.filter(event) as ErrorEvent;
    }

    if (event != null) {
      strategyProvider.resolve(event);
    }
  }
}
