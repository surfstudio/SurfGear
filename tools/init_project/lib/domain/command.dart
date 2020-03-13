/// TODO заполнить
class Command {
  final String _nameProject;
  final String _path;
  final String _remoteUrl;
  final String _branch;

  Command(this._nameProject, {String path, String remoteUrl, String branch})
      : assert(_nameProject != null),
        _remoteUrl = remoteUrl,
        _path = path,
        _branch = branch;

  /// Имя проекта
  String get nameProject => _nameProject;

  /// Путь до дирректории
  String get path => _path;

  /// url зависимостей
  String get url => _remoteUrl;

  /// Вектка зависимостей
  String get branch => _branch;
}
