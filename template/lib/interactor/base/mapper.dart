/// Базовый класс для маппинга из [F] в [T]
abstract class Mapper<F, T> {
    F data;

    Mapper.of(this.data);

    T map();
}
