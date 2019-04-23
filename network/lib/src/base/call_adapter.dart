///Адаптер для запроса в сеть
abstract class CallAdapter<T, R> {
  R adapt(T call);
}
