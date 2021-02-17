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

import 'package:flutter/foundation.dart';
import 'package:mwwm/src/model/changes/changes.dart';
import 'package:mwwm/src/model/exceptions.dart';
import 'package:mwwm/src/model/performer/performer.dart';

/// Model is a mediator between WidgetModel and business logic.
///
/// Model abstracts the client (WidgetModel) from the supplier (repository,
/// service, storage, etc) and defines the contract between presentation and
/// service layers, thus allowing to develop both independently.
///
/// Model consists of [Change] and [Performer].
class Model {
  final List<Performer> _performers;

  Model(this._performers);

  /// Perform some change inside business logic once
  R perform<R>(Change<R> change) {
    for (var p in _performers) {
      try {
        debugPrint('[PERFORM] $p try to perform $change');
        if (p.canPerform(change)) {
          return p.perform(change);
        } 
      } catch (e) {
        rethrow;
      }
    }

    throw NoPerformerException(change);
  }

  /// Listen to changes of exact type
  Stream<R> listen<R, C extends FutureChange<R>>() {
    for (var p in _performers) {
      try {
        if (p is Broadcast<R, C>) {
          return p.broadcast;
        } else {
          continue;
        }
      } on TypeError catch (e) {
        debugPrint(e.toString());
        continue;
      } catch (e) {
        return Stream.error(e);
      }
    }

    return Stream.error(NoBroadcastPerformerException(C));
  }
}
