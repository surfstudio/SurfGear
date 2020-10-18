///  Пути для сертификата
class PathCertificate {
  /// Имя файла сертификата
  final String name;

  /// Где лежит сертификат
  final String inputPath;

  /// Куда положить сертификат
  final String outputPath;

  PathCertificate({
    this.inputPath,
    this.outputPath,
    this.name,
  });
}
