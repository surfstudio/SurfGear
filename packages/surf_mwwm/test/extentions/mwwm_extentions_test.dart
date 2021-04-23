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

import 'package:flutter_test/flutter_test.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

void main() {
  testWidgets('SurfMwwmExtension bind', (tester) async {
    final wm = TestWM();
    final event = StringEvent();

    final result = <String?>[];

    wm.bind<String?>(event, (value) => result.add(value));

    await event.accept("wow");
    await event.accept("rly");

    expect(result, equals(['wow', 'rly']));
  });

  group('FutureExt', () {
    testWidgets('on', (tester) async {
      final wm = TestWM();
      final event = StringEvent();

      final result = <String?>[];

      await event.accept("wow").on(wm).then((value) => result.add(value));
      await event.accept("rly").on(wm).then((value) => result.add(value));

      expect(result, equals(['wow', 'rly']));
    });

    testWidgets('withErrorHandling', (tester) async {
      final errors = <Object>[];

      final expectedException = Exception('error');

      final fetchSomething = () async {
        throw expectedException;
      };

      final onError = (error) {
        errors.add(error);
      };

      final wm = TestWM(
        baseDependencies: WidgetModelDependencies(
          errorHandler: TestErrorHandler(onError),
        ),
      );

      try {
        await fetchSomething().withErrorHandling(wm);
      } on Exception {
        expect(errors, equals([expectedException]));
      }
    });
  });
}

class TestErrorHandler extends ErrorHandler {
  final void Function(Object e) onError;

  TestErrorHandler(this.onError);

  @override
  void handleError(Object e) => onError(e);
}

class TestWM extends WidgetModel {
  TestWM({
    WidgetModelDependencies baseDependencies = const WidgetModelDependencies(),
  }) : super(baseDependencies);
}

class StringEvent extends Event<String> {
  final _controller = StreamController<String?>();

  @override
  Future<String?> accept([String? data]) async {
    _controller.add(data);
    return data;
  }

  @override
  Stream<String?> get stream => _controller.stream;

  void dispose() async {
    await _controller.close();
  }
}
