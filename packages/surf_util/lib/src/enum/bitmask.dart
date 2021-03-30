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

import 'package:surf_util/src/enum/enum.dart';

/// A generic implementation of the Bitmask type.
///
/// Each value must be a power of two.
abstract class Bitmask extends Enum<int> {
  const Bitmask(int value)
      : assert(value > 0 && (value & (value - 1) == 0)),
        super(value);

  /// Возвращает значение маски по списку значений
  static int getMask(Iterable<Bitmask> list) =>
      list.fold(0, (value, element) => value | element.value);

  /// Выполняет проверку на активность флага.
  bool isOn(int mask) {
    return (mask & value) != 0;
  }
}
