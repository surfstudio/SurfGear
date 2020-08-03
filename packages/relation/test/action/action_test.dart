import 'package:flutter_test/flutter_test.dart';
import 'package:relation/src/relation/action/action.dart';

void main() {
  test('Action accept([T data]) test', () {
    final action = Action<String>();

    action.stream.listen((event) {
      expect('test', event);
    });

    action.accept('test');
  });

  test('Action call([T data]) test', () {
    final action = Action<String>();

    action.stream.listen((event) {
      expect('test', event);
    });

    action.call('test');
  });

  test('Action dispose() test', () {
    final action = Action<String>()..dispose();
    expect(true, action.subject.isClosed);
  });
}
