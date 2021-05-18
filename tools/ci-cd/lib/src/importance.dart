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

class ChangesImportance implements Comparable<ChangesImportance> {
  const ChangesImportance._(this._value);

  static const unknown = ChangesImportance._('unknown');
  static const patch = ChangesImportance._('patch');
  static const minor = ChangesImportance._('minor');
  static const major = ChangesImportance._('major');

  static const values = [
    ChangesImportance.unknown,
    ChangesImportance.patch,
    ChangesImportance.minor,
    ChangesImportance.major,
  ];

  final String _value;

  static ChangesImportance fromString(String value) => values.firstWhere(
        (val) => val._value == value.toLowerCase(),
        orElse: () => ChangesImportance.unknown,
      );

  @override
  String toString() => _value;

  @override
  int compareTo(ChangesImportance other) =>
      values.indexOf(this).compareTo(values.indexOf(other));

  bool operator <(ChangesImportance other) => compareTo(other) < 0;
  bool operator <=(ChangesImportance other) => compareTo(other) <= 0;
  bool operator >(ChangesImportance other) => compareTo(other) > 0;
  bool operator >=(ChangesImportance other) => compareTo(other) >= 0;
}
