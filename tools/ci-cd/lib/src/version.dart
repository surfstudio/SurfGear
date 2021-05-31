import 'package:ci_cd/src/importance.dart';
import 'package:pub_semver/pub_semver.dart';

const _devPattern = 'dev';

Version bumpStablePackageVersion(
  Version version,
  ChangesImportance importance,
) {
  switch (importance) {
    case ChangesImportance.major:
      return version.nextMajor;
    case ChangesImportance.minor:
      return version.nextMinor;
    default:
      return version.nextPatch;
  }
}

Version bumpUnstablePackageVersion(
  Version version,
  ChangesImportance importance,
) {
  if (!version.isPreRelease) {
    var newVersion = version;
    switch (importance) {
      case ChangesImportance.major:
        newVersion = version.nextMajor;
        break;
      case ChangesImportance.minor:
        newVersion = version.nextMinor;
        break;
      default:
        newVersion = version.nextPatch;
        break;
    }

    return Version(
      newVersion.major,
      newVersion.minor,
      newVersion.patch,
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
