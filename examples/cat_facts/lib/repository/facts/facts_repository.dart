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

import 'dart:convert';

import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/repository/api_client.dart';

/// Репозиторий для работы с фактами
class FactsRepository {
  final ApiClient client;

  const FactsRepository(this.client);

  /// Получить список фактов
  Future<Iterable<Fact>> getFacts() async {
    final response = await client.get('/facts');

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final data =
          (jsonDecode(response.body) as Iterable).cast<Map<String, dynamic>>();
      return data.map<Fact>((e) => Fact.fromJson(e)).toList();
    } else {
      return const <Fact>[];
    }
  }
}
