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
import 'package:storage/storage.dart';

void main() {
  // final storage = JsonStorage("filename");

  // setUp(storage.clear);

  // print('Test for this module can not work on this platform');

  test('test', () {
    expect(true, isTrue);
  });

//  StorageTest.testEmptyGet(storage);
//  StorageTest.testPutGet(storage);
//  StorageTest.testPutGetRichValue(storage);
//  StorageTest.testMultipleValues(storage);
//  StorageTest.testClear(storage);
//  StorageTest.testRewriteValue(storage);
}

abstract class StorageTest {
  static void testEmptyGet(Storage storage) {
    test('testEmptyGet', () async {
      final nullValue = await storage.get('someKey') as Object;
      expect(nullValue, null);
    });
  }

  static void testPutGet(Storage storage) {
    test('testPutGet', () async {
      final value = {
        'key1': 'value1',
        'key2': 'value2',
      };

      storage.put('someKey', value);
      final savedValue = await storage.get('someKey') as Object;
      expect(savedValue, value);
    });
  }

  static void testPutGetRichValue(Storage storage) {
    test('testPutGetRichValue', () async {
      final value = {
        'stringKey': 'stringValue',
        'intKey': 42,
        'doubleKey': 42.42,
        'boolKey': true,
      };

      storage.put('someKey', value);
      final savedValue = await storage.get('someKey') as Object;
      expect(savedValue, value);
    });
  }

  static void testMultipleValues(Storage storage) {
    test('testMultipleValues', () async {
      final value1 = {'key1': 'value1'};
      final value2 = {'key2': 42};
      final value3 = {'key3': true};

      storage
        ..put('someKey1', value1)
        ..put('someKey2', value2)
        ..put('someKey3', value3);

      final savedValue1 = await storage.get('someKey1') as Object;
      final savedValue2 = await storage.get('someKey2') as Object;
      final savedValue3 = await storage.get('someKey3') as Object;

      expect(savedValue1, value1);
      expect(savedValue2, value2);
      expect(savedValue3, value3);
    });
  }

  static void testClear(Storage storage) {
    test('testClear', () async {
      final value = {'key': 'value'};
      storage
        ..put('someKey', value)
        ..clear();

      final nullValue = await storage.get('someKey') as Object;
      expect(nullValue, null);
    });
  }

  static void testRewriteValue(Storage storage) {
    test('testRewriteValue', () async {
      final value = {'key': 'value'};
      storage.put('someKey', value);

      final newValue = {'newKey': 'newValue'};
      storage.put('someKey', newValue);

      final savedValue = await storage.get('someKey') as Object;
      expect(savedValue, newValue);
    });
  }
}
