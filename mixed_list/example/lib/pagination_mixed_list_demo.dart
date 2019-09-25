import 'dart:async';

import 'package:example/item_builder.dart';
import 'package:example/items/circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:mixed_list/mixed_list.dart';
import 'package:datalist/datalist.dart';

import 'dart:convert';
import 'items/post.dart';

Client client = Client();

Future<OffsetDataList<Post>> getPostList(int offset, int limit) async {
  Response postList = await client.get(
    "http://jsonplaceholder.typicode.com/posts?_start=$offset&_limit=$limit",
  );
  return OffsetDataList<Post>(
    data: _parsePostList(postList.body),
    offset: offset,
    limit: limit,
  );
}

//Parsing
List<Post> _parsePostList(String responseBody) {
  final data = json.decode(responseBody);
  List<Post> postList = data.map<Post>((json) => Post.fromJson(json)).toList();

  return postList;
}

class PaginationMixedListDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaginationMixedListDemo();
  }
}

///Необходимо доделать пагинацию.
///На текущий момент происходит бесконечная загрузка данных, из-за getPostList(0, 10)
///Т.е каждый раз когда надо подгрузить данные происходит загрузка с того-же момента
///
/// Несмотря на то что в поток приходят новые данные, в методе build не происходит отрисовка...
class _PaginationMixedListDemo extends State<PaginationMixedListDemo> {
  StreamController<PaginationState> paginationController = StreamController();
  StreamController<OffsetDataList<Post>> itemsController = StreamController();
  int offset = 0;

  void _loadItems() {
    paginationController.sink.add(PaginationState.loading);
    getPostList(0, 10).then((response) {
      if (response.isEmpty) {
        paginationController.sink.add(PaginationState.complete);
      } else {
        itemsController.sink.add(response);
        paginationController.sink.add(PaginationState.none);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OffsetDataList<Post>>(
      stream: itemsController.stream,
      initialData: OffsetDataList(
          data: List.generate(5, (index) => Post(id: 1, body: "data")),
          limit: 5,
          offset: 0),
      builder: (ctx, postList) {
        return StreamBuilder<PaginationState>(
          initialData: PaginationState.none,
          stream: paginationController.stream,
          builder: (ctx, state) {
            return PaginationMixedList(
              items: postList.data,
              supportedItemControllers: {
                Post: PostBuilder(),
              },
              listMode: ListMode.list,
              onLoadMore: _loadItems,
              currentPaginationState: state.data,
              paginationFooterBuilder: (context, state) {
                if (state == PaginationState.loading ||
                    state == PaginationState.none) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          },
        );
      },
    );
  }
}
