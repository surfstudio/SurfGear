/// Интерфейс задачи.
abstract class Task<R> {
  Future<R> run();
}

/// Интерфейс задачи проверки.
abstract class Check extends Task<bool> {}

/// Интерфейс задачи без возвращения ответа.
abstract class Action extends Task<void> {}