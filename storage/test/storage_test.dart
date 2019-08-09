import 'package:flutter_test/flutter_test.dart';
import 'package:storage/storage.dart';

void main() {
  final storage = JsonStorage("filename");

  setUp(storage.clear);

  StorageTest.testEmptyGet(storage);
  StorageTest.testPutGet(storage);
  StorageTest.testPutGetRichValue(storage);
  StorageTest.testMultipleValues(storage);
  StorageTest.testClear(storage);
  StorageTest.testRewriteValue(storage);
}

abstract class StorageTest {
  static void testEmptyGet(Storage storage) {
    test("testEmptyGet", () async {
      final nullValue = await storage.get("someKey");
      expect(nullValue, null);
    });
  }

  static void testPutGet(Storage storage) {
    test("testPutGet", () async {
      final value = {
        "key1": "value1",
        "key2": "value2",
      };

      storage.put("someKey", value);
      final savedValue = await storage.get("someKey");
      expect(savedValue, value);
    });
  }

  static void testPutGetRichValue(Storage storage) {
    test("testPutGetRichValue", () async {
      final value = {
        "stringKey": "stringValue",
        "intKey": 42,
        "doubleKey": 42.42,
        "boolKey": true,
      };

      storage.put("someKey", value);
      final savedValue = await storage.get("someKey");
      expect(savedValue, value);
    });
  }

  static void testMultipleValues(Storage storage) {
    test("testMultipleValues", () async {
      final value1 = {"key1": "value1"};
      final value2 = {"key2": 42};
      final value3 = {"key3": true};

      storage.put("someKey1", value1);
      storage.put("someKey2", value2);
      storage.put("someKey3", value3);

      final savedValue1 = await storage.get("someKey1");
      final savedValue2 = await storage.get("someKey2");
      final savedValue3 = await storage.get("someKey3");

      expect(savedValue1, value1);
      expect(savedValue2, value2);
      expect(savedValue3, value3);
    });
  }

  static void testClear(Storage storage) {
    test("testClear", () async {
      final value = {"key": "value"};
      storage.put("someKey", value);

      storage.clear();

      final nullValue = await storage.get("someKey");
      expect(nullValue, null);
    });
  }

  static void testRewriteValue(Storage storage) {
    test("testRewriteValue", () async {
      final value = {"key": "value"};
      storage.put("someKey", value);

      final newValue = {"newKey": "newValue"};
      storage.put("someKey", newValue);

      final savedValue = await storage.get("someKey");
      expect(savedValue, newValue);
    });
  }
}
