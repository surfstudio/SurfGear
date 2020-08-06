// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/config/env/env.dart';

///URL запросов сервера
abstract class Url {
  static String get prodProxyUrl => '';

  static String get qaProxyUrl => '192.168.0.1';

  static String get devProxyUrl => '';

  static String get testUrl => 'http://uinames.com/api/';

  static String get prodUrl => 'https://prod.surfstudio.ru/api';

  static String get devUrl => 'https://localhost:9999/food/hs/ExchangeSotr';

  static String get baseUrl => Environment<Config>.instance().config.url;
}
