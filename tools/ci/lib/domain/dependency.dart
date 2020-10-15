import 'package:ci/domain/element.dart';

/// Обёртка над библиотекой, предоставляющая информацию
/// о том, как она может быть подключена.
abstract class Dependency {
  /// Подключаемая библиотека, от которой
  /// зависит работа других библиотек.
  final Element element;

  /// Зависимость не из flutter-standard
  final bool thirdParty;

  Dependency(
    this.element,
    this.thirdParty,
  );
}

/// Библиотека, подключённая через гит.
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

  GitDependency.byTemplate(
    GitDependency oldDependency, {
    String url,
    String path,
    String ref,
    Element element,
    bool thirdParty,
  })  : url = url ?? oldDependency.url,
        path = path ?? oldDependency.path,
        ref = ref ?? oldDependency.ref,
        super(
          element ?? oldDependency.element,
          thirdParty ?? oldDependency.thirdParty,
        );
}

/// Библиотека, подключённая локально.
class PathDependency extends Dependency {
  /// Путь до библиотеки.
  final String path;

  PathDependency({
    this.path,
    Element element,
    bool thirdParty,
  }) : super(element, thirdParty);

  PathDependency.byTemplate(
    PathDependency oldDependency, {
    String path,
    Element element,
    bool thirdParty,
  })  : path = path ?? oldDependency.path,
        super(
          element ?? oldDependency.element,
          thirdParty ?? oldDependency.thirdParty,
        );
}

/// Библиотека, подключённая через pub.
class HostedDependency extends Dependency {
  /// Версия библиотеки.
  final String version;

  HostedDependency({
    this.version,
    Element element,
    bool thirdParty,
  }) : super(element, thirdParty);

  HostedDependency.byTemplate(
    HostedDependency oldDependency, {
    String version,
    Element element,
    bool thirdParty,
  })  : version = version ?? oldDependency.version,
        super(
          element ?? oldDependency.element,
          thirdParty ?? oldDependency.thirdParty,
        );
}
