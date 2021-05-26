import 'package:pub_semver/pub_semver.dart';

const _devPattern = 'dev';

Version bumpDevPackageVersion(Version version) {
  if (!version.isPreRelease) {
    return Version(
      version.major,
      version.minor,
      version.patch + 1,
      pre: '$_devPattern.1',
    );
  }

  final currentDevVersion = version.preRelease
      // ignore: implicit_dynamic_parameter
      .firstWhere((item) => item is int, orElse: () => 0) as int;

  return Version(
    version.major,
    version.minor,
    version.patch,
    pre: '$_devPattern.${currentDevVersion + 1}',
  );
}
