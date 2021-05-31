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

import 'test_utils.dart';

void main() {
  group('SwipeRefresh.material', () {
    late StreamController<SwipeRefreshState> _controller;
    late Stream<SwipeRefreshState> stream;

    setUp(() {
      _controller = StreamController<SwipeRefreshState>.broadcast();
      stream = _controller.stream;
    });

    tearDown(() async {
      await _controller.close();
    });

    Future<void> _onRefresh() async {
      await Future<void>.delayed(const Duration(seconds: 3));

      _controller.sink.add(SwipeRefreshState.hidden);
    }

    group("doesn't break", () {
      testWidgets('with children as argument', (tester) async {
        final testWidget = makeTestableWidget(
          SwipeRefresh.material(
            stateStream: stream,
            onRefresh: _onRefresh,
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
    });

    testWidgets('emits hidden state on drag after 3 seconds', (tester) async {
      final events = <SwipeRefreshState>[];

      stream.listen(expectAsync1<void, SwipeRefreshState>(events.add));

      final testWidget = makeTestableWidget(
        SwipeRefresh.material(
          stateStream: stream,
          onRefresh: _onRefresh,
          children: const [
            SizedBox(height: 100),
            SizedBox(height: 100),
          ],
        ),
      );

      await tester.pumpWidget(testWidget);

      expect(events, isEmpty);

      /// drag is not enouth to trugger refresh
      await tester.drag(find.byType(SwipeRefresh), const Offset(0, 100));

      expect(events, isEmpty);

      await tester.drag(find.byType(SwipeRefresh), const Offset(0, 300));

      await tester.pump(const Duration(seconds: 1));

      /// event must reveal after 3 seconds
      expect(events, isEmpty);

      await tester.pump(const Duration(seconds: 3));

      expect(events, equals([SwipeRefreshState.hidden]));
    });
    testWidgets('shows custom indicator if specified', (tester) async {
      const indicator = Text('0');
      final testWidget = makeTestableWidget(
        MaterialSwipeRefresh(
          stateStream: stream,
          onRefresh: _onRefresh,
          indicator: indicator,
          children: Colors.primaries
              .map((e) => Container(
                    color: e,
                    height: 100,
                  ))
              .toList(),
        ),
      );

      await tester.pumpWidget(testWidget);
      await tester.drag(
        find.byType(MaterialSwipeRefresh),
        const Offset(0, 300),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.byWidget(indicator), findsOneWidget);
    });
  });
}
