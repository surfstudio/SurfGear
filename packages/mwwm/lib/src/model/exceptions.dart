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

import 'package:mwwm/src/model/changes/changes.dart';

/// Not found any performer for change
class NoPerformerException implements Exception {
  final Change change;

  const NoPerformerException(this.change);

  @override
  String toString() {
    return 'No performer found for $change';
  }
}

/// Not found Broadcast for this Change
class NoBroadcastPerformerException implements Exception {
  final Type change;

  const NoBroadcastPerformerException(this.change);

  @override
  String toString() {
    return 'No broadcast found for $change';
  }
}
