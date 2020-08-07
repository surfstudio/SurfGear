/// Базовый класс для маппинга из [F] в [T]
/// * Типичный кейс трансформации: Domain -> Request, Response -> Domain
/// * Главная особенность: возможность из [F] получить множество различных [T]
/// * путём разделения на несколько наследником [Mapper]
abstract class Mapper<F, T> {
  Mapper.of(this.data);

  F data;

  T map();
}
