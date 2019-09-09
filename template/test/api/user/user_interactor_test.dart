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

import 'package:test_api/test_api.dart';

import '../base/mock_app.dart';
import '../base/test_extensions.dart';

main() {
    var app = MockAppComponent();
    _testSummary(app);
}

void _testSummary(MockAppComponent app) {
    test("Тест запроса данных о пользователе", () {
        final request = app.userInteractor.getUser();
        expectNotNull(request);
    });
}
