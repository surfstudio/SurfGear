import 'package:mockito/mockito.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:test/test.dart';

class RemoteUserLogStrategyMock extends Mock implements RemoteUserLogStrategy {}

void main() {
  group('RemoteLogger', () {
    const userId = '0';
    const username = 'test';
    const email = 'test@example.com';

    const message = 'Howdy';
    final exception = Exception('exception');

    late RemoteUserLogStrategyMock strategyMock;

    setUp(() {
      strategyMock = RemoteUserLogStrategyMock();
    });

    test("setUser calls strategy's setUser", () {
      RemoteLogger.addStrategy(strategyMock);

      RemoteLogger.setUser(userId, username, email);
      verify(strategyMock.setUser(userId, username, email));
      RemoteLogger.removeStrategy(strategyMock);
      RemoteLogger.setUser(userId, username, email);
      verifyNever(strategyMock.setUser(
        any as String,
        any as String,
        any as String,
      ));
    });

    test('WIP', () {
      RemoteLogger.clearUser();
      verify(strategyMock.clearUser());

      RemoteLogger.log(message);
      verify(strategyMock.log(message));

      RemoteLogger.logError(exception);
      verify(strategyMock.logError(exception));

      RemoteLogger.removeStrategy(strategyMock);
      RemoteLogger.log(message);
      verifyNever(strategyMock.log(message));

      RemoteLogger.addStrategy(strategyMock);
      RemoteLogger.addStrategy(strategyMock);

      RemoteLogger.removeStrategy(strategyMock);

      RemoteLogger.log(message);
      verify(strategyMock.log(message));
    });
  });
}
