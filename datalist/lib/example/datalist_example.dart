import 'dart:convert';

import 'package:http/http.dart';
import '../src/impl/datalist_limit_offset.dart';
import 'user.dart';

void main() async{
  OffsetDataList page1Users = await _getUserList(10, 0);
  OffsetDataList page2Users = await _getUserList(10, page1Users.nextOffset);

  print(page1Users.merge(page2Users).toString());
}

Client _client = Client();

Future<OffsetDataList<User>> _getUserList(int limit, int offset) async {
  Response res = await _client
      .get("https://api.github.com/users?per_page=$limit&since=$offset");

  final data = json.decode(res.body);

  List<User> userList = data.map<User>((json) => User.fromJson(json)).toList();

  return OffsetDataList(
    data: userList,
    limit: limit,
    offset: offset,
  );
}