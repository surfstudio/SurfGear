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

/// Key-value storage
abstract class Storage<K, V> {
  /// Get object or null if it doesn't exist
  Future<V> get(K key);

  /// Save object or rewrite it if there is the same key
  /// Descendants can change this logic.
  void put(K key, V value);

  /// Remove object
  void remove(K key);

  /// Clear storage
  void clear();
}
