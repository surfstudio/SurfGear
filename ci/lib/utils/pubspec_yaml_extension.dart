import 'package:plain_optional/plain_optional.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';

extension PubspecYamlExtension on PubspecYaml {
  PubspecYaml change({
    String version,
    String description,
    List<String> authors,
    String homepage,
    String repository,
    String issueTracker,
    String documentation,
    String publishTo,
    Iterable<PackageDependencySpec> dependencies,
    Iterable<PackageDependencySpec> devDependencies,
    Iterable<PackageDependencySpec> dependencyOverrides,
    Map<String, String> environment,
    Map<String, Optional<String>> executables,
    Map<String, dynamic> customFields,
  }) {
    return PubspecYaml(
      name: name,
      version: version == null ? this.version : Optional(version),
      description:
      description == null ? this.description : Optional(description),
      homepage: homepage == null ? this.homepage : Optional(homepage),
      repository: repository == null ? this.repository : Optional(repository),
      issueTracker:
      issueTracker == null ? this.issueTracker : Optional(issueTracker),
      documentation:
      documentation == null ? this.documentation : Optional(documentation),
      publishTo: publishTo == null ? this.publishTo : Optional(publishTo),
      dependencies: dependencies ?? this.dependencies,
      devDependencies: devDependencies ?? this.devDependencies,
      dependencyOverrides: dependencyOverrides ?? this.dependencyOverrides,
      environment: environment ?? this.environment,
      executables: executables ?? this.executables,
      customFields: customFields ?? this.customFields,
    );
  }
}