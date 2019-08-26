import 'widget_model.dart';

///Стейт некоторой логической сущности
class EntityState<T> {
  final T data;
  final bool isLoading;
  final bool hasError;
  ExceptionWrapper error;

  //возможные поля
  // final List<Exception> errors

  EntityState({
    this.data,
    this.isLoading = false,
    this.hasError = false,
    dynamic error,
  }): error = ExceptionWrapper(error);

  EntityState.loading()
      : isLoading = true,
        hasError = false,
        data = null;

  EntityState.error([dynamic error])
      : isLoading = false,
        hasError = true,
        error = ExceptionWrapper(error),
        data = null;

  EntityState.content([T data])
      : isLoading = false,
        hasError = false,
        data = data;
}
