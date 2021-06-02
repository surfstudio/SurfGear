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
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

// ignore_for_file: deprecated_member_use_from_same_package
void main() {
  test('SurfMwwmExtension bind', () async {
    final wm = TestWM();
    final event = StreamedAction<String>();

    final result = <String?>[];

    wm.bind<String?>(event, result.add);

    await event.accept('wow');
    await event.accept('rly');

    expect(result, equals(['wow', 'rly']));
  });

  test('SurfMwwmExtension bindVoid', () async {
    final wm = TestWM();
    final action = VoidAction();

    final result = <String>[];

    wm.bindVoid(action, () => result.add('1'));
    await action();
    await action();

    expect(result, equals(['1', '1']));
  });

  group('FutureExt', () {
    test('on', () async {
      final wm = TestWM();

      final result = <String?>[];

      await Future.value('wow').on(wm).then(result.add);
      await Future.value('rly').on(wm).then(result.add);

      expect(result, equals(['wow', 'rly']));
    });

    test('on with error', () async {
      final wm = TestWM();

      final result = <String?>[];

      await Future.value('wow').on(wm).then(result.add);

      try {
        await Future<void>.error(Exception()).on(
          wm,
          onError: (e) {
            result.add('rly');
          },
        );
      } on Exception catch (_) {
        expect(result, equals(['wow', 'rly']));
      }
    });

    test('withErrorHandling', () async {
      final errors = <Object>[];

      final expectedException = Exception('error');

      Future fetchSomething() async {
        throw expectedException;
      }

      Future<void> onError(Object error) async {
        errors.add(error);
      }

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

  group('Event', () {
    test('bind', () async {
      final event = StringEvent();
      final result = <String?>[];

      event.bind(result.add);

      await event.accept('wow');
      await event.accept('rly');

      expect(result, equals(['wow', 'rly']));
    });

    test('listenOn', () async {
      final wm = TestWM();
      final event = StringEvent();

      final result = <String?>[];

      event.listenOn(wm, onValue: result.add);

      await event.accept('wow');
      await event.accept('rly');

      expect(result, equals(['wow', 'rly']));
    });
  });

  group('StreamX', () {
    test('listenOn', () async {
      // ignore: close_sinks
      final _controller = StreamController<String?>(sync: true);
      final stream = _controller.stream;

      final wm = TestWM();

      final result = <String?>[];

      stream.listenOn(wm, onValue: result.add);

      _controller..add('wow')..add('rly');

      expect(result, equals(['wow', 'rly']));
    });

    test('listenCatchError', () async {
      // ignore: close_sinks
      final _controller = StreamController<String?>(sync: true);
      final stream = _controller.stream;

      final wm = TestWM();

      final result = <String?>[];

      stream.listenCatchError(
        wm,
        onValue: result.add,
        onError: (error) {
          result.add('rly');
        },
      );

      _controller
        ..add('wow')
        ..addError('error');

      expect(result, equals(['wow', 'rly']));
    });
  });

  testWidgets(
    'context.getComponent',
    (tester) async {
      final component = TestComponent('home');

      late final BuildContext context;

      final widget = MaterialApp(
        home: Injector(
          builder: (_context) {
            context = _context;
            return Container();
          },
          component: component,
        ),
      );

      await tester.pumpWidget(widget);

      expect(context.getComponent<TestComponent>(), equals(component));
    },
  );
}

class TestComponent extends Component {
  TestComponent(this.data);

  final String data;
}

class TestErrorHandler extends ErrorHandler {
  TestErrorHandler(this.onError);

  final void Function(Object e) onError;

  @override
  void handleError(Object e) => onError(e);
}

class TestWM extends WidgetModel {
  TestWM({
    WidgetModelDependencies baseDependencies = const WidgetModelDependencies(),
  }) : super(baseDependencies);
}

class StringEvent extends Event<String> {
  final _controller = StreamController<String>();

  @override
  Stream<String> get stream => _controller.stream;

  @override
  Future<void> accept(String data) async {
    _controller.add(data);
    return Future.value(null);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}
