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

import 'package:surf_util/surf_util.dart';

/// base type for a list of tabs
/// adding new types of tabs via the create() method
abstract class TabType extends Enum<int> {
  const TabType(int value) : super(value);

  static const emptyValue = -1;

  static const values = <TabType>[];

  static void create(TabType newTab) {
    values.add(newTab);
  }

  static TabType byValue(int ordinal) {
    return values.firstWhere(
      (value) => ordinal == value.value,
      orElse: () => throw Exception('Unknown TabType by ordinal $ordinal'),
    );
  }
}
