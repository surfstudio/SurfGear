import 'dart:convert';
import 'package:example/interactor/data/user.dart';
import 'package:network/network.dart';
import 'package:rxdart/rxdart.dart';

class UsersRepository {
  RxHttp _http;

  UsersRepository(this._http);

  Observable<User> getUser(int userId) =>
      _http.get("url").map((res) => User.fromJson(res.body));

  Observable<List<User>> getUserList() =>
      _http.get("url").map((res) => _parseUsers(res.body.toString()));

  List<User> _parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
