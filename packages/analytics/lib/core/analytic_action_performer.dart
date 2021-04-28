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

import 'package:analytics/core/analytic_action.dart';

/// A performer of specific actions used to incapsulate work with
/// a certain analytics service. Typically implemented by transforming
/// [AnalyticAction] into a required format as well as calling `send()`
/// of a third-party library.
abstract class AnalyticActionPerformer<A extends AnalyticAction> {
  const AnalyticActionPerformer();

  bool canHandle(AnalyticAction action) => action is A;

  void perform(A action);
}
