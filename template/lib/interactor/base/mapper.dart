abstract class Mapper<F, T> {
  F data;

  Mapper.of(this.data);

  T map();
}
