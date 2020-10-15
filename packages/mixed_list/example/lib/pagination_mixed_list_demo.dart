// Copyright (c) 2019-present,  SurfStudio LLC
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

import 'dart:async';
import 'dart:math';

import 'package:datalist/datalist.dart';
import 'package:example/item_builder.dart';
import 'package:example/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mixed_list/mixed_list.dart';

import 'items/post.dart';

/// Widget for demonstration Mixed List pagination.
class PaginationMixedListDemo extends StatefulWidget {
  const PaginationMixedListDemo({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaginationMixedListDemo();
}

class _PaginationMixedListDemo extends State<PaginationMixedListDemo> {
  StreamController<PaginationState> paginationController = StreamController();
  StreamController<OffsetDataList<Post>> itemsController = StreamController();

  final _dataList = OffsetDataList<Post>.empty();

  @override
  void initState() {
    paginationController.sink.add(PaginationState.none);

    super.initState();
  }

  void _loadNext() {
    paginationController.sink.add(PaginationState.loading);
    getPostList(_dataList.nextOffset, 10,
            emulateSlowConnect: Random().nextBool())
        .then((response) {
      if (response.isEmpty) {
        paginationController.sink.add(PaginationState.complete);
      } else {
        itemsController.sink.add(response);
        paginationController.sink.add(PaginationState.none);
      }
      // ignore: avoid_types_on_closure_parameters
    }).catchError((dynamic error) {
      paginationController.sink.add(PaginationState.error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OffsetDataList<Post>>(
      stream: itemsController.stream,
      initialData: _dataList,
      builder: (ctx, postList) {
        _dataList.merge(postList.data);
        return PaginationMixedList(
          items: _dataList,
          supportedItemControllers: {
            Post: PostBuilder(),
          },
          listMode: ListMode.list,
          onLoadMore: _loadNext,
          paginationState: paginationController.stream,
          paginationFooterBuilder: (context, state) {
            if (state == PaginationState.loading) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state == PaginationState.error) {
              return Container(
                height: 50,
                color: const Color(0xFFFF0000),
                child: Center(
                  child: FlatButton(
                    onPressed: _loadNext,
                    child: const Text('Press to reload'),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    paginationController.close();
    itemsController.close();

    super.dispose();
  }
}
