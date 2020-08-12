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

extension JsonExtensions on Map<String, dynamic> {
  /// Return [T] value from json by [key]
  T get<T>(String key, {T defaultValue}) {
    if (key == null) return defaultValue;

    final dynamic value = this[key];
    if (value == null) return defaultValue;

    if (value is T) {
      return value;
    } else {
      throw Exception('Type: $T is not value type: ${value.runtimeType}');
    }
  }
}
