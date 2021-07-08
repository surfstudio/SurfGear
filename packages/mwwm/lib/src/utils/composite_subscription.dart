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

import 'dart:async';

/// inspired by rxDart
///
/// Acts as a container for multiple subscriptions that can be canceled at once
/// e.g. view subscriptions in Flutter that need to be canceled on view disposal
///
/// Can be cleared or disposed. When disposed, cannot be used again.
/// ### Example
/// // init your subscriptions
/// composite.add(observable1.listen(listener1))
/// ..add(observable2.listen(listener1))
/// ..add(observable3.listen(listener1));
///
/// // clear them all at once
/// composite.clear();
class CompositeSubscription {
  bool _isDisposed = false;

  final _subscriptionsList = <StreamSubscription<Object?>>[];

  /// Checks if this composite is disposed. If it is, the composite can't be used again
  /// and will throw an error if you try to add more subscriptions to it.
  bool get isDisposed => _isDisposed;

  /// Adds new subscription to this composite.
  ///
  /// Throws an exception if this composite was disposed
  StreamSubscription<T> add<T>(StreamSubscription<T> subscription) {
    if (isDisposed) {
      throw Exception(
        'This composite was disposed, try to use new instance instead',
      );
    }
    _subscriptionsList.add(subscription);
    return subscription;
  }

  /// Cancels subscription and removes it from this composite.
  void remove(StreamSubscription<Object?> subscription) {
    subscription.cancel();
    _subscriptionsList.remove(subscription);
  }

  /// Cancels all subscriptions added to this composite. Clears subscriptions collection.
  ///
  /// This composite can be reused after calling this method.
  void clear() {
    _subscriptionsList
      ..forEach((subscription) => subscription.cancel())
      ..clear();
  }

  /// Cancels all subscriptions added to this composite. Disposes this.
  ///
  /// This composite can't be reused after calling this method.
  void dispose() {
    clear();
    _isDisposed = true;
  }
}
