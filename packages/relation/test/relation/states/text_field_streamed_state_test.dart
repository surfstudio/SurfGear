import 'package:flutter_test/flutter_test.dart';
import 'package:relation/relation.dart';

void main() {
  test('TextFieldStreamedState accepts error if form is not valid', () async {
    final entityStreamedState = TextFieldStreamedState('', validator: 'txt');
    await entityStreamedState.content('text');
    expect(entityStreamedState.value.hasError, isTrue);
  });
  test('TextFieldStreamedState accepts content if form is valid', () async {
    final entityStreamedState = TextFieldStreamedState('', validator: 'text');
    await entityStreamedState.content('text');
    expect(entityStreamedState.value.hasError, isFalse);
    expect(entityStreamedState.value.data, 'text');
  });
  test(
    'TextFieldStreamedState accepts error if data isEmpty and mandatory',
    () async {
      final entityStreamedState =
          TextFieldStreamedState('', validator: 'text', mandatory: true);

      await entityStreamedState.content('text');
      await entityStreamedState.content('');
      expect(entityStreamedState.value.hasError, isTrue);
    },
  );
}
