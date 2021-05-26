import 'dart:convert';

import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/interactor/api_client.dart';

class FactsRepository {
  const FactsRepository(this.client);

  final ApiClient client;

  Future<Iterable<Fact>> getFacts() async {
    final response = await client.get('/facts');

    if (response.statusCode == 200) {
      final data =
          (jsonDecode(response.body) as Iterable).cast<Map<String, dynamic>>();
      return data.map<Fact>((e) => Fact.fromJson(e)).toList();
    } else {
      return const <Fact>[];
    }
  }
}
