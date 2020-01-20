import 'package:ci/domain/element.dart';

/// Обёртка над библиотекой, предоставляющая информацию
/// о том, как она может быть подключена.
abstract class Dependency {
  /// Подключаемая библиотека, от которой
  /// зависит работа других библиотек.
  final Element element;

  ///
  final bool thirdParty;

  Dependency(
    this.element,
    this.thirdParty,
  );
}

/// Библиотека, находящаяся в гит-репозитории.
class GitDependency extends Dependency {
  /// Адрес репозитория.
  final String url;

  /// Путь до директории, в которой находится библиотека.
  final String path;

  /// Название ветки или тега.
  final String ref;

  GitDependency({
    this.url,
    this.path,
    this.ref,
    Element element,
    bool thirdParty,
  }) : super(element, thirdParty);
}

/// Библиотека, находящаяся локально.
class PathDependency extends Dependency {
  /// Путь до библиотеки.
  final String path;

  PathDependency({
    this.path,
    Element element,
    bool thirdParty,
  }) : super(element, thirdParty);
}

/// Библиотека, выложенная в pub.
class HostedDependency extends Dependency {
  /// Версия библиотеки.
  final String version;

  HostedDependency({
    this.version,
    Element element,
    bool thirdParty,
  }) : super(element, thirdParty);
}
