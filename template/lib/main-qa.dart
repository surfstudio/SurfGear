

import 'package:flutter_template/config/base/build_types.dart';
import 'package:flutter_template/config/base/env/env.dart';
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/runner/runner.dart';

//Main entry point of app
void main() {
  Environment.init(
    buildType: BuildType.qa,
    config: Config(
      url: TEST_URL,
    ),
  );

  run();
}
