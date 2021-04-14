import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mwwm/src/model/exceptions.dart';
import 'package:mwwm/src/model/model.dart';

import 'mocks/change_mock.dart';
import 'mocks/performer_mock.dart';

void main() {
  group('Model', () {
    late Model model;
    late PerformerMock<int, ChangeMock<int>> performerMock;
    late ChangeMock<int> changeMock;

    late PerformerMock<String, ChangeMock<String>> performerStringMock;

    setUp(() {
      registerFallbackValue<ChangeMock<int>>(ChangeMock<int>());
      registerFallbackValue<ChangeMock<String>>(ChangeMock<String>());

      performerMock = PerformerMock<int, ChangeMock<int>>();
      performerStringMock = PerformerMock<String, ChangeMock<String>>();

      model = Model([
        performerStringMock,
        performerMock,
      ]);

      changeMock = ChangeMock<int>();
    });

    group('perform()', () {
      test('returns result of perform passed changes by optimal performer', () {
        const changes = 4;

        when(() => performerMock.canPerform(any<int>())).thenReturn(true);
        when(() => performerStringMock.canPerform(any<String>()))
            .thenReturn(false);
        when(() => performerMock.perform(any())).thenReturn(changes);

        expect(model.perform(changeMock), changes);
        verifyNever(() => performerStringMock.perform(any()));
      });

      test('returns NoPerformerException if no found perfomer', () {
        when(() => performerMock.canPerform(any<int>())).thenReturn(false);
        when(() => performerStringMock.canPerform(any<String>()))
            .thenReturn(false);

        expect(() => model.perform(changeMock),
            throwsA(isA<NoPerformerException>()));
      });
    });
  });
}
