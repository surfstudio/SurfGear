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

import 'package:flutter_test/flutter_test.dart';
import 'package:surf_util/src/enum/bitmask.dart';
import 'package:surf_util/src/enum/int_extension.dart';

class TestBitmask extends Bitmask {
  const TestBitmask(int value) : super(value);
}

void main() {
  test('isOn returns true if checked value contains provided mask', () {
    expect(15.isOn(const TestBitmask(0x0001)), isTrue);
    expect(15.isOn(const TestBitmask(0x0100)), isFalse);
  });
}
