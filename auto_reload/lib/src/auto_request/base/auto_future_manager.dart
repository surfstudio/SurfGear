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

/// return id of success future in queue
typedef AutoFutureCallback = Function(String id);

/// Manager for endless replay [Future], until will not be performed
abstract class AutoFutureManager {
  /// register [Future] to auto reload
  ///
  /// [id] - number of future in queue
  /// [toReload] - himself future on reboot
  /// [onComplete] - callback of success future, that returns id in queue
  Future<void> autoReload({
    String id,
    Future toReload(),
    AutoFutureCallback onComplete,
  });
}
