/// TODO заполнить
class Command {
  final String _nameProject;
  final String _path;
  final String _url;
  final String _branch;

  Command(this._nameProject, this._path, this._url, this._branch) : assert(_nameProject != null);

  String get nameProject => _nameProject;

  String get path => _path;

  String get url => _url;

  String get branch => _branch;
}
