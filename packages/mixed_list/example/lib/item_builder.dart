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

import 'package:example/items/circle.dart';
import 'package:example/items/post.dart';
import 'package:example/items/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mixed_list/mixed_list.dart';

class PostBuilder extends ItemBuilder<Post> {
  @override
  Widget build(BuildContext context, data) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
      child: Card(
        child: Column(
          children: <Widget>[
            Text('POST ITEM ${data.id}'),
            Text(
              data.body,
            ),
          ],
        ),
      ),
    );
  }
}

class CircleBuilder extends ItemBuilder<Circle> {
  @override
  Widget build(BuildContext context, Circle data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class RectBuilder extends ItemBuilder<Rect> {
  @override
  Widget build(BuildContext context, data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: 64,
          height: 64,
          color: Colors.red,
        ),
      ),
    );
  }
}

class UserBuilder extends ItemBuilder<User> {
  @override
  Widget build(BuildContext context, User data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: <Widget>[
            Image.asset(
              data.avatar,
              width: 128,
              height: 128,
            ),
            Column(
              children: <Widget>[
                Text(data.userName),
                Text(data.dateOfBirth),
              ],
            )
          ],
        ),
      ),
    );
  }
}
