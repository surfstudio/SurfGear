import 'package:ci/domain/dependency.dart';

/// Представление библиотеки
class Element {
  /// Название библиотеки.
  final String name;

  /// Версия библиотеки.
  final String version;

  /// Список зависимостей, необходимых для работы
  /// библиотеки.
  List<Dependency> dependencies;

  /// Дополнительная информация для библиотек, выложенных
  /// в открытый доступ. Может быть null.
  final OpenSourceInfo openSourceInfo;

  /// Готова ли библиотека использоваться в проде.
  final bool isStable;

  /// Число, увеличивающееся при каждом изменении
  /// библиотеки на 1 до тех пор, пока библиотека
  /// не станет stable ([isStable] == true).
  /// В случае stable значение этого поля равно нулю.
  final int unstableVersion;

  /// Есть ли библиотека в pub.
  bool get hosted => openSourceInfo != null;

  /// Использует ли библиотека специфичный для платформы код.
  final bool isPlugin;

  /// Относительный путь до библиотеки.
  /// Фактически, это название директории, в которой
  /// она находится.
  final String path;

  /// Модуль был изменён в рамках пулл реквеста.
  bool changed;

  Element({
    this.name,
    this.version,
    this.dependencies,
    this.openSourceInfo,
    this.isStable,
    this.unstableVersion,
    this.isPlugin,
    this.path,
    this.changed = false,
  });
}

/// Информация для open source библиотек.
class OpenSourceInfo {
  /// Адрес индивидуального репозитория, если существует.
  final String separateRepoUrl;

  /// Адрес pub сервера.
  final String hostUrl;

  OpenSourceInfo({this.separateRepoUrl, this.hostUrl});
}
