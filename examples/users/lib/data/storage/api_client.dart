import 'dart:convert';

import 'package:example2/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  final http.Client httpClient;

  ApiClient({required this.httpClient});

  Future<List<User>> fecthUsers() async {
    const mainUrl = '$baseUrl/users';

    final usersResponse = await httpClient.get(Uri.parse(mainUrl));

    if (usersResponse.statusCode != 200) {
      throw Exception('error getting users');
    }

    List<User> usersList = (json.decode(usersResponse.body) as List)
        .map((e) => User.fromJson(e))
        .toList();

    return usersList;
  }
}
