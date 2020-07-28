import 'dart:convert';

import 'package:datalist/datalist.dart';
import 'package:example/items/post.dart';
import 'package:http/http.dart';

Client client = Client();

int _debugErrorCounter = 0;

Future<OffsetDataList<Post>> getPostList(
  int offset,
  int limit, {
  bool emulateSlowConnect = false,
}) async {
  final Response postList = await client.get(
    'http://jsonplaceholder.typicode.com/posts?_start=$offset&_limit=$limit',
  );

  if (emulateSlowConnect) {
    await Future<void>.delayed(const Duration(seconds: 3));
  }

  _debugErrorCounter++;

  if (_debugErrorCounter % 3 == 0) {
    return Future.error('TEST!');
  }

  return OffsetDataList<Post>(
    data: _parsePostList(postList.body),
    offset: offset,
    limit: limit,
  );
}

//Parsing
List<Post> _parsePostList(String responseBody) {
  final data = json.decode(responseBody) as List<Map<String, Object>>;
  final List<Post> postList =
      data.map<Post>((json) => Post.fromJson(json)).toList();

  return postList;
}
