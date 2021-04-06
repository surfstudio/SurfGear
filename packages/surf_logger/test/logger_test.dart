import 'package:mocktail/mocktail.dart';
import 'package:surf_logger/src/const.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:test/test.dart';

class DebugLogStrategyMock extends Mock implements DebugLogStrategy {}

class RemoteLogStrategyMock extends Mock implements RemoteLogStrategy {}

void main() {
  group('Logger', () {
    const debug = 'debug';
    const warning = 'warning';
    const error = 'error';

    late DebugLogStrategyMock debugStrategy;
    late RemoteLogStrategyMock remoteStrategy;

    setUp(() {
      debugStrategy = DebugLogStrategyMock();
      remoteStrategy = RemoteLogStrategyMock();
    });

    test('works with DebugLogStrategy', () {
      Logger.addStrategy(debugStrategy);

      Logger.d(debug);
      verify(() => debugStrategy.log(debug, priorityLogDebug));

      Logger.w(warning);
      verify(() => debugStrategy.log(warning, priorityLogWarn));

      Logger.e(error);
      verify(() => debugStrategy.log(error, priorityLogError));

      Logger.removeStrategy(debugStrategy);

      Logger.d(debug);
      verifyNever(() => debugStrategy.log(debug, priorityLogDebug));

      Logger.w(warning);
      verifyNever(() => debugStrategy.log(warning, priorityLogWarn));

      Logger.e(error);
      verifyNever(() => debugStrategy.log(error, priorityLogError));
    });

    test('works with RemoteLogStrategy', () {
      Logger.addStrategy(remoteStrategy);

      Logger.d(debug);
      verify(() => remoteStrategy.log(debug, priorityLogDebug));

      Logger.w(warning);
      verify(() => remoteStrategy.log(warning, priorityLogWarn));

      Logger.e(error);
      verify(() => remoteStrategy.log(error, priorityLogError));

      Logger.removeStrategy(remoteStrategy);

      Logger.d(debug);
      verifyNever(() => remoteStrategy.log(debug, priorityLogDebug));

      Logger.w(warning);
      verifyNever(() => remoteStrategy.log(warning, priorityLogWarn));

      Logger.e(error);
      verifyNever(() => remoteStrategy.log(error, priorityLogError));
    });

    test('works both strategies', () {
      Logger.addStrategy(debugStrategy);
      Logger.addStrategy(remoteStrategy);

      Logger.d(debug);
      verify(() => remoteStrategy.log(debug, priorityLogDebug));
      verify(() => debugStrategy.log(debug, priorityLogDebug));

      Logger.removeStrategy(debugStrategy);

      Logger.d(debug);
      verify(() => remoteStrategy.log(debug, priorityLogDebug));
      verifyNever(() => debugStrategy.log(debug, priorityLogDebug));

      Logger.removeStrategy(remoteStrategy);

      Logger.d(debug);
      verifyNever(() => remoteStrategy.log(debug, priorityLogDebug));
      verifyNever(() => debugStrategy.log(debug, priorityLogDebug));
    });

    test('works with exceptions', () {
      Logger.addStrategy(debugStrategy);
      Logger.addStrategy(remoteStrategy);

      final e = Exception('eception');

      Logger.d(debug, e);
      verify(() => debugStrategy.log(debug, priorityLogDebug, e));
      verify(() => remoteStrategy.log(debug, priorityLogDebug, e));
    });
  });
}
