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

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

Widget makeTestableWidget(Widget widget) => MaterialApp(home: widget);

void main() {
  group('SwipeRefresh', () {
    final _controller = StreamController<SwipeRefreshState>.broadcast();
    final stream = _controller.stream;

    tearDown(() async {
      await _controller.close();
    });

    Future<void> _refresh() async {
      await Future<void>.delayed(const Duration(seconds: 3));

      _controller.sink.add(SwipeRefreshState.hidden);
    }

    group("doesn't break", () {
      testWidgets('with children as argument', (tester) async {
        final testWidget = makeTestableWidget(
          SwipeRefresh.material(
            stateStream: stream,
            onRefresh: _refresh,
            children: Colors.primaries
                .map(
                  (e) => Container(
                    color: e,
                    height: 100,
                  ),
                )
                .toList(),
          ),
        );

        await tester.pumpWidget(testWidget);
      });

      testWidgets('with itemBuilder as argument', (tester) async {
        final testWidget = makeTestableWidget(
          SwipeRefresh.builder(
            stateStream: stream,
            onRefresh: _refresh,
            itemCount: Colors.primaries.length,
            itemBuilder: (_, index) => Container(
              color: Colors.primaries[index],
              height: 100,
            ),
          ),
        );

        await tester.pumpWidget(testWidget);
      });
    });
  });
}
