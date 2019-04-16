import 'package:logger/src/const.dart';
import 'package:logger/src/remote_logger.dart';
import 'package:logger/src/strategies/log_strategy.dart';

const minRemotePriority = PRIORITY_LOG_ERROR;

///Стратегия для отправки логов на удалённый сервер
///* логи отправляются начиная с [minRemotePriority]
class RemoteLogStrategy extends LogStrategy {
  @override
  void log(String message, int priority, [Exception error]) {
    if (priority < minRemotePriority) return;

    RemoteLogger.log(message);

    if (error != null) {
      RemoteLogger.logError(error);
    }
  }
}
