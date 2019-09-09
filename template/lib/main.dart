/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter_template/config/base/build_types.dart';
import 'package:flutter_template/config/base/env/env.dart';
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/runner/runner.dart';

//Main entry point of app
void main() async {
  Environment.init(
    buildType: BuildType.debug,
    config: Config(
      url: TEST_URL,
    ),
  );

  run();
}
