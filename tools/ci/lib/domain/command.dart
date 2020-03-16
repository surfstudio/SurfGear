/// Представление команды, которую необходимо выполнить.
class Command {
  /// Название команды
  final String name;

  /// Параметры
  final Map<String, dynamic> arguments;

  Command(
    this.name,
    Map<String, dynamic> arguments,
  ) : arguments = arguments ?? <String, dynamic>{};
}
