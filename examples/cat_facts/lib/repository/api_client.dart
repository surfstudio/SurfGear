// Copyright (c) 2019-present, SurfStudio LLC
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

import 'package:http/http.dart';

/// Класс для взаимодействия с API слоем.
class ApiClient {
  final Client httpClient;

  final String _baseUrl;

  ApiClient(this._baseUrl, this.httpClient);

  Future<Response> get(String endpoint, {Map<String, String>? params}) {
    final queryString = Uri(queryParameters: params).query;
    return httpClient.get(Uri.parse('$_baseUrl$endpoint?$queryString'));
  }
}
