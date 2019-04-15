///Стейт некоторой логической сущности,
abstract class EntityState<T> {
  final T data;
  final bool isLoading;
  final bool hasError;
  Exception error;

  //возможные поля
  // final List<Exception> errors

  EntityState.loading()
      : isLoading = true,
        hasError = false,
        data = null;

  EntityState.error([Exception error])
      : isLoading = false,
        hasError = true,
        error = error,
        data = null;

  EntityState.none(T data)
      : isLoading = false,
        hasError = false,
        data = data;
}
