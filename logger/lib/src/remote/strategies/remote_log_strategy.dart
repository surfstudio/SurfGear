///Стратегия для отправки логов на удалённый сервер
abstract class RemoteLogStrategy {
  void setUser(String id, String username, String email);

  void clearUser();

  void log(String message);

  void logError(dynamic error);

  void logInfo(String key, dynamic info);
}
