import 'dart:convert';

import 'package:datalist/datalist.dart';
import 'package:datalist_example/interactor/data/user.dart';
import 'package:http/http.dart';

class UserRepository {
  Client client;

  UserRepository(this.client);

  Future<OffsetDataList<User>> getUserList2(int offset, int limit) async {
    Response userList = await client.get(
      "https://api.github.com/users?per_page=$limit&since=$offset",
    );

    print(userList.body);

    return OffsetDataList(
      data: _parseUserList(userList.body),
      offset: offset,
      limit: limit
    );
  }

  List<User> _parseUserList(String responseBody) {
    final data = json.decode(responseBody);
    List<User> userList =
        data.map<User>((json) => User.fromJson(json)).toList();

    return userList;
  }
}
