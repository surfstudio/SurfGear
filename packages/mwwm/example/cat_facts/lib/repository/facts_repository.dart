import 'dart:convert';
import 'dart:developer';

import 'package:cat_facts/interactor/api_client.dart';
import 'package:cat_facts/data/facts/fact.dart';

class FactsRepository {
  static Future<Iterable<Fact>> getFacts() async {
    final response = await ApiClient.get('/facts');
    log(response.toString());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Iterable;
      return data.map<Fact>((e) => Fact.fromJson(e)).toList();
    } else {
      return const <Fact>[];
    }
  }
}
