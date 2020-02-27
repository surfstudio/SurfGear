import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:meta/meta.dart';

/// Представление тега.
abstract class Tag {
  /// Возвращает строковое представление тега.
  String get tagName;
}

/// Тег содержащий версию.
class VersionedTag implements Tag {
  final String name;
  final int version;

  VersionedTag({this.name, @required this.version});

  /// Возвращает строковое представление тега.
  @override
  String get tagName =>
      (name != null && name.isNotEmpty ? name + '-' : '') + version.toString();

  /// Возвращает новый Tag c увеличением версии на 1
  VersionedTag inc() => VersionedTag(name: name, version: version + 1);
}

/// Начало названия проектной ветки.
const String _projectTagStart = 'project-';

/// Представление тега проектной ветки.
///
/// Тег проектной ветки ОБЯЗАТЕЛЬНО начинается с project-.
class ProjectTag extends VersionedTag {
  static final RegExp _projectTagExp = RegExp(r'^(project-\w+)-(\d+)$');

  ProjectTag(
    String name,
    int version,
  )   : assert(
          name.startsWith(_projectTagStart),
        ),
        super(
          name: name,
          version: version,
        );

  static ProjectTag parseFrom(String tagString) {
    if (!_projectTagExp.hasMatch(tagString)) {
      throw FormatException(
        getFormatExceptionText(
          'Формат проектного тега должен быть project-name-#',
        ),
      );
    }

    var match = _projectTagExp.firstMatch(tagString);
    return ProjectTag(match.group(1), int.parse(match.group(2)));
  }
}
