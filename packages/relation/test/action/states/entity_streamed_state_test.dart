import 'package:flutter_test/flutter_test.dart';
import 'package:relation/relation.dart';

void main() {
  test('EntityStreamedState content test', () {
    final entityStreamedState = EntityStreamedState<String>();
    entityStreamedState.stream.listen((event) {
      expect(event.data, 'test');
    });
    entityStreamedState.content('test');
  });

  test('EntityStreamedState error test', () {
    final entityStreamedState = EntityStreamedState<String>();
    entityStreamedState.stream.listen((event) {
      expect(event.error.e.message, 'error test');
    });
    entityStreamedState.error(Exception('error test'));
  });

  test('EntityStreamedState loading test', () {
    final entityStreamedState = EntityStreamedState<String>();
    entityStreamedState.stream.listen((event) {
      expect(event.isLoading, true);
    });
    entityStreamedState.loading();
  });
}
