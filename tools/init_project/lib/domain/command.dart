/// TODO заполнить
class Command {
  final String _nameProject;
  final String _path;
  final String _url;

  Command(this._nameProject, this._path, this._url) : assert(_nameProject != null);

  String get nameProject => _nameProject;

  String get path => _path;

  String get url => _url;
}
