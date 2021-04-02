import 'package:mocktail/mocktail.dart';
import 'package:surf_logger/src/const.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:test/test.dart';

class RemoteUserLogStrategyMock extends Mock implements RemoteUserLogStrategy {}

void main() {
  group('RemoteLogStrategy', () {
    const message = 'test message';

    late RemoteLogStrategy strategy;
    late RemoteUserLogStrategyMock userStrategyMock;

    setUp(() {
      strategy = RemoteLogStrategy();
      userStrategyMock = RemoteUserLogStrategyMock();
    });

    test('log with 3rd (highest) priority', () {
      RemoteLogger.addStrategy(userStrategyMock);
      strategy.log(message, priorityLogError);
      verify(() => userStrategyMock.log(message));

      RemoteLogger.removeStrategy(userStrategyMock);
      strategy.log(message, priorityLogError);
      verifyNever(() => userStrategyMock.log(message));
    });

    test('log with 2nd (medium) priority', () {
      RemoteLogger.addStrategy(userStrategyMock);
      strategy.log(message, priorityLogWarn);
      verify(() => userStrategyMock.log(message));

      RemoteLogger.removeStrategy(userStrategyMock);
      strategy.log(message, priorityLogWarn);
      verifyNever(() => userStrategyMock.log(message));
    });

    test("don't log with 1nd (lowest) priority", () {
      RemoteLogger.addStrategy(userStrategyMock);
      strategy.log(message, priorityLogDebug);
      verifyNever(() => userStrategyMock.log(message));

      RemoteLogger.removeStrategy(userStrategyMock);
      strategy.log(message, priorityLogDebug);
      verifyNever(() => userStrategyMock.log(message));
    });

    test('log errors', () {
      final error = Exception('some exception');
      RemoteLogger.addStrategy(userStrategyMock);
      strategy.log(message, priorityLogError, error);
      verify(() => userStrategyMock.log(message));
      verify(() => userStrategyMock.logError(error));

      strategy.log(message, priorityLogWarn, error);
      verify(() => userStrategyMock.log(message));
      verify(() => userStrategyMock.logError(error));

      /// This message shouldn't be logged since lowest priority
      strategy.log(message, priorityLogDebug, error);
      verifyNever(() => userStrategyMock.log(message));
      verifyNever(() => userStrategyMock.logError(error));
    });
  });
}
