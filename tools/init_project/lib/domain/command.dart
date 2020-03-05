class Command {
  final String _nameProject;
  final String _path;

  Command(this._nameProject, this._path) : assert(_nameProject != null);

  String get nameProject => _nameProject;

  String get path => _path;
}
