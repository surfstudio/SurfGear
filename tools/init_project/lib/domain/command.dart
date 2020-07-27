/// Параметры команды, которую необходимо выполнить.
class Command {
  /// Имя проекта
  final String _nameProject;

  /// Путь до дирректории
  final String _path;

  /// url зависимостей
  final String _remoteUrl;

  /// Вектка зависимостей
  final String _branch;

  /// Organization identifier
  final String _organizationId;

  Command(
    this._nameProject,
    this._remoteUrl,
    this._organizationId, {
    String path,
    String branch,
  })  : assert(_nameProject != null),
        assert(_remoteUrl != null),
        assert(_organizationId != null),
        _path = path,
        _branch = branch;

  String get nameProject => _nameProject;

  String get path => _path;

  String get remoteUrl => _remoteUrl;

  String get branch => _branch;

  String get organizationId => _organizationId;
}
