import 'package:example/item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'items/circle.dart';
import 'items/user.dart';

import 'package:mixed_list/mixed_list.dart';

class MixedListDemo extends StatelessWidget {
  final List mixedListItems = List();

  MixedListDemo() {
    for (int i = 0; i < 10; i++) {
      mixedListItems.add(Circle());
//      mixedListItems.add(rect.Rect());
      mixedListItems.add(Circle());
      mixedListItems.add(User(
        dateOfBirth: "01.01.1991",
        userName: "Mr.Robot",
        avatar: "assets/images/avatar1.jpeg",
      ));
      mixedListItems.add(Circle());
      mixedListItems.add(User(
        dateOfBirth: "01.01.1970",
        userName: "John Wick",
        avatar: "assets/images/avatar2.jpg",
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
