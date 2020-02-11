import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';

/// Представление тега.
class Tag {
  final String name;
  final int version;

  Tag(this.name, this.version);

  /// Возвращает строковое представление тега.
  String get tagName => name + '-' + version.toString();

  /// Возвращает новый Tag c увеличением версии на 1
  Tag inc() => Tag(name, version + 1);
}

/// Начало названия проектной ветки.
const String _projectTagStart = 'project-';

/// Представление тега проектной ветки.
///
/// Тег проектной ветки ОБЯЗАТЕЛЬНО начинается с project-.
class ProjectTag extends Tag {
  static final RegExp _projectTagExp = RegExp(r'^(project-\w+)-(\d+)$');

  ProjectTag(
    String name,
    int version,
  )   : assert(
          name.startsWith(_projectTagStart),
        ),
        super(
          name,
          version,
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
