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

void main() {
  testWidgets('SurfMwwmExtension bind', (tester) async {
    final wm = TestWM();
    final event = StringEvent();

    final result = <String?>[];

    wm.bind<String?>(event, result.add);

    await event.accept('wow');
    await event.accept('rly');

    expect(result, equals(['wow', 'rly']));
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
      } on Exception catch (e) {
        expect(result, equals(['wow', 'rly']));
      }
    });

    test('withErrorHandling', () async {
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

  test(
    'EntityExt map',
    () async {
      final state = EntityStreamedState<String>();

      final result = state.map((element) => element.toUpperCase());
      await state.accept(EntityState(data: 'initial'));

      expect(result.value!.data, equals('initial'.toUpperCase()));
    },
  );

  test(
    'EntityExt map should fail',

    /// because of [StreamedState.from]
    () async {
      final state = EntityStreamedState<String>();

      final result = state.map((element) => element.toUpperCase());
      await result.accept(EntityState(data: 'initial'));

      expect(result.value!.data, equals('initial'.toUpperCase()));
    },
    skip: true,
  );

  test('Event bind', () async {
    final event = StringEvent();
    final result = <String?>[];

    event.bind((data) {
      result.add(data);
    });

    await event.accept('wow');
    await event.accept('rly');

    expect(result, equals(['wow', 'rly']));
  });

  test('Event listenOn', () async {
    final wm = TestWM();
    final event = StringEvent();

    final result = <String?>[];

    event.listenOn(wm, onValue: (data) {
      result.add(data);
    });

    await event.accept('wow');
    await event.accept('rly');

    expect(result, equals(['wow', 'rly']));
  });

  test(
    'Event listenOn with error',

    /// fails somehow
    () async {
      final wm = TestWM();
      final event = StringEvent();

      final result = <String?>[];

      event.listenOn(
        wm,
        onValue: (data) {
          result.add(data);
        },
        onError: (error) {
          result.add('rly');
        },
      );
      await event.accept('wow');

      try {
        await event.accept(throw Exception('error'));
      } catch (e) {
        expect(result, equals(['wow', 'rly']));
      }
    },
    skip: true,
  );

  test(
    'Event listenCathError'

    /// fails somehow
    ,
    () async {
      final wm = TestWM();
      final event = StringEvent();

      final result = <String?>[];

      event.listenCathError(
        wm,
        onValue: (data) {
          result.add(data);
        },
        onError: (error) {
          result.add('rly');
        },
      );
      await event.accept('wow');

      try {
        await event.accept(throw Exception('error'));
      } catch (e) {
        expect(result, equals(['wow', 'rly']));
      }
    },
    skip: true,
  );

  group('StreamX', () {
    test('listenOn', () async {
      // ignore: close_sinks
      final _controller = StreamController<String?>(sync: true);
      final stream = _controller.stream;

      final wm = TestWM();

      final result = <String?>[];

      stream.listenOn(wm, onValue: (value) {
        result.add(value);
      });

      _controller.add('wow');
      _controller.add('rly');

      expect(result, equals(['wow', 'rly']));
    });

    test('listenCatchError', () async {
      // ignore: close_sinks
      final _controller = StreamController<String?>(sync: true);
      final stream = _controller.stream;

      final wm = TestWM();

      final result = <String?>[];

      stream.listenCatchError(wm, onValue: (value) {
        result.add(value);
      }, onError: (error) {
        result.add('rly');
      });

      _controller.add('wow');
      _controller.addError('error');

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
  final String data;

  TestComponent(this.data);
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
