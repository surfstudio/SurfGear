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
import 'package:flutter_template/domain/counter.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/screen/welcome_screen/welcome_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injector/injector.dart';
import 'package:mockito/mockito.dart';

class AppComponentMock extends Mock implements AppComponent {}

class CounterInteractorMock extends Mock implements CounterInteractor {}

CounterInteractorMock getCounterInteractor() {
  final mock = CounterInteractorMock();

  when(mock.counterObservable)
      .thenAnswer((_) => Stream<Counter>.value(Counter(111)));

  return mock;
}

AppComponentMock getAppComponent() {
  final mock = AppComponentMock();

  when(mock.counterInteractor).thenAnswer((_) => getCounterInteractor());

  return mock;
}

void main() {
  setUp(() {});

  tearDown(() {});

  testWidgets('find widgets', (widgetTester) async {
    final appComponent = getAppComponent();
    await widgetTester.pumpWidget(
      Injector<AppComponent>(
        component: appComponent,
        builder: (context) {
          return MaterialApp(
            home: WelcomeScreen(),
          );
        },
      ),
    );
    await widgetTester.pumpAndSettle();

    verify(appComponent.counterInteractor).called(1);
  });
}
