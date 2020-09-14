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

import 'package:mixed_list/mixed_list.dart';

import 'package:example/item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'items/circle.dart';
import 'items/user.dart';

class MixedListDemo extends StatelessWidget {
  MixedListDemo({Key key}) : super(key: key) {
    for (int i = 0; i < 10; i++) {
      mixedListItems
        ..add(Circle())
        ..add(Circle())
        ..add(User(
          dateOfBirth: '01.01.1991',
          userName: 'Mr.Robot',
          avatar: 'res/assets/images/avatar1.jpeg',
        ))
        ..add(Circle())
        ..add(User(
          dateOfBirth: '01.01.1970',
          userName: 'John Wick',
          avatar: 'res/assets/images/avatar2.jpg',
        ));
    }
  }

  final List mixedListItems = <Object>[];

  @override
  Widget build(BuildContext context) {
    return MixedList(
      supportedItemControllers: {
        User: UserBuilder(),
        Circle: CircleBuilder(),
//        rect.Rect: RectBuilder(),
      },
      items: mixedListItems,
      listMode: ListMode.list,
    );
  }
}
