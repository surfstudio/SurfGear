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
}
