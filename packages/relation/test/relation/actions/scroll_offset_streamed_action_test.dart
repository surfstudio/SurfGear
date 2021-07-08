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

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:relation/relation.dart';
import 'package:rxdart/subjects.dart';

void main() {
  testWidgets(
    'ScrollOffsetAction test',
    (tester) async {
      // ignore: deprecated_member_use_from_same_package
      final action = ScrollOffsetAction(onChanged: (data) {
        expect(data, equals(1.0));
      });

      await tester.pumpWidget(MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('test'),
          ),
          body: ListView(
            controller: action.controller,
            children: const <Widget>[
              Text('test'),
              Text('test'),
              Text('test'),
            ],
          ),
        ),
      ));

      action.controller.jumpTo(1.0);
    },
  );

  testWidgets(
    'ScrollOffsetAction dispose test',
    (tester) async {
      final action = ScrollOffsetAction();

      await tester.pumpWidget(MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('test'),
          ),
          body: ListView(
            controller: action.controller,
            children: const [
              Text('test'),
              Text('test'),
              Text('test'),
            ],
          ),
        ),
      ));

      await action.dispose();
      expect((action.stream as Subject).isClosed, isTrue);
    },
  );
}
