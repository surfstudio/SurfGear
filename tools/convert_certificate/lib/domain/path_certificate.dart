/// Path for certificate.
class PathCertificate {
  /// Certificate file name.
  final String name;

  /// Where is the certificate.
  final String inputPath;

  /// Where to put the certificate.
  final String outputPath;

  PathCertificate({
    this.inputPath,
    this.outputPath,
    this.name,
  });
}
