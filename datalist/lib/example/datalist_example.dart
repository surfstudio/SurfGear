import 'dart:convert';

import 'package:http/http.dart';
import '../src/impl/datalist_limit_offset.dart';
import 'user.dart';

void main() {
  _init();
}

void _init() async {
  OffsetDataList page1User = await _getUserList(10, 0);
  OffsetDataList page2User = await _getUserList(10, page1User.nextOffset);

  print(page1User.merge(page2User).toString());
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
