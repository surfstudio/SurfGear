import 'package:mocktail/mocktail.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:test/test.dart';

class RemoteUserLogStrategyMock extends Mock implements RemoteUserLogStrategy {}

void main() {
  group('RemoteLogger', () {
    const userId = '0';
    const username = 'test';
    const email = 'test@example.com';

    late RemoteUserLogStrategyMock strategyMock;

    setUp(() {
      strategyMock = RemoteUserLogStrategyMock();
    });

    test("setUser calls strategy's setUser", () {
      RemoteLogger.addStrategy(strategyMock);

      RemoteLogger.setUser(userId, username, email);
      verify(() => strategyMock.setUser(userId, username, email));

      RemoteLogger.removeStrategy(strategyMock);
      RemoteLogger.setUser(userId, username, email);
      verifyNever(() => strategyMock.setUser(userId, username, email));
    });

    test("clearUser calls strategy's clearUser", () {
      RemoteLogger.addStrategy(strategyMock);

      RemoteLogger.clearUser();
      verify(() => strategyMock.clearUser());

      RemoteLogger.removeStrategy(strategyMock);
      RemoteLogger.clearUser();
      verifyNever(() => strategyMock.clearUser());
    });

    test("logs calls strategy's logs", () {
      const message = 'Howdy';
      final exception = Exception('exception');
      const key = 'key';
      const info = {'wow': 'wow'};

      RemoteLogger.addStrategy(strategyMock);

      RemoteLogger.log(message);
      verify(() => strategyMock.log(message));

      RemoteLogger.logError(exception);
      verify(() => strategyMock.logError(exception));

      RemoteLogger.logInfo(key, info);
      verify(() => strategyMock.logInfo('key', info));

      RemoteLogger.removeStrategy(strategyMock);

      RemoteLogger.log(message);
      verifyNever(() => strategyMock.log(message));
      RemoteLogger.logError(exception);
      verifyNever(() => strategyMock.logError(exception));
      RemoteLogger.logInfo(key, info);
      verifyNever(() => strategyMock.logInfo(key, 'info'));
    });

    test('add method supposed to set an old value to a new one', () {
      final strategyMock2 = RemoteUserLogStrategyMock();
      RemoteLogger.addStrategy(strategyMock);
      RemoteLogger.addStrategy(strategyMock2);

      /// This method should remove both strategies
      RemoteLogger.removeStrategy(strategyMock);

      RemoteLogger.log('message');
      verifyNever(() => strategyMock2.log('message'));
    });
  });
}
