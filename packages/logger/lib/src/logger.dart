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

import 'package:logger/src/const.dart';
import 'package:logger/src/strategies/log_strategy.dart';

/// Wrapping for logging using various strategies
class Logger {
  static final _strategies = Map<Type, LogStrategy>();

  ///debug
  static void d(String msg, [Exception error]) {
    _forAllStrategies(
      (strategy) => strategy.log(msg, PRIORITY_LOG_DEBUG, error),
    );
  }

  ///warn (for expected errors)
  static void w(String msg, [Exception error]) {
    _forAllStrategies(
      (strategy) => strategy.log(msg, PRIORITY_LOG_WARN, error),
    );
  }

  ///error (for errors)
  static void e(String msg, [Exception error]) {
    _forAllStrategies(
      (strategy) => strategy.log(msg, PRIORITY_LOG_ERROR, error),
    );
  }

  static void addStrategy(LogStrategy strategy) {
    _strategies[strategy.runtimeType] = strategy;
  }

  static void removeStrategy(LogStrategy strategy) {
    _strategies.remove(strategy.runtimeType);
  }

  static void _forAllStrategies(Function(LogStrategy strategy) action) {
    _strategies.values.forEach(action);
  }
}
