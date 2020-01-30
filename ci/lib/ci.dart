/// Приложение для Continuous Integration.
///
/// TODO: было бы не плохо чтоб всё это жило дольше чем выполнение 1 команды,
/// тогда бы мы могли единовременно выполнять инициализацию
/// и использовать некоторое окружение
class Ci {
  static Ci _instance;

  static Ci get instance => _instance ??= Ci._();

  Ci._();

  /// Выполняет действие исходя из переданных параметров.
  void execute(List<String> arguments) async {}
}
