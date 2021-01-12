/// Path for certificate.
class ConversionParams {
  /// Certificate file name.
  final String name;

  /// Where is the certificate.
  final String inputPath;

  /// Where to put the certificate.
  final String outputPath;

  ConversionParams({
    this.inputPath,
    this.outputPath,
    this.name,
  });
}
