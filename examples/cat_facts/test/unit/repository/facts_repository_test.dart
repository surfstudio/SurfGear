import 'package:cat_facts/repository/api_client.dart';
import 'package:cat_facts/repository/facts/facts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

/// Тесты для [FactsRepository]
void main() {
  late ApiClientMock appClient;
  late FactsRepository factsRepository;

  setUp(() {
    appClient = ApiClientMock();

    factsRepository = FactsRepository(appClient);
  });

  test(
    'getFacts should make correct request to api',
    () {
      when(
        () => appClient.get(
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          Response('', 200),
        ),
      );

      factsRepository.getFacts(10);

      verify(() => appClient.get('/facts')).called(1);
    },
  );
}

class ApiClientMock extends Mock implements ApiClient {}
