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

import 'package:auto_reload/src/auto_reload/auto_reload_mixin.dart';
import 'package:auto_reload/src/auto_reload/auto_reloader.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

const testDuration = Duration(minutes: 1);
const testDurationLag = Duration(seconds: 10);

class AutoReloaderMock extends Mock implements AutoReloader {}

class TestAutoReloader extends AutoReloaderMock with AutoReloadMixin {
  @override
  Duration get autoReloadDuration => testDuration;
}

class TestAutoReloadMixin extends AutoReloader with AutoReloadMixin {}

void main() {
  group('AutoReloadMixin', () {
    test('default duraton is five minutes', () {
      expect(TestAutoReloadMixin().autoReloadDuration.inMinutes, equals(5));
    });

    group('startAutoReload', () {
      late TestAutoReloader reloader;

      setUp(() {
        reloader = TestAutoReloader();
      });

      test('performs autoReload after configured timeout', () {
        fakeAsync((async) {
          reloader.startAutoReload();

          async.elapse(testDuration + testDurationLag);

          verify(reloader.autoReload());
        });
      });
      test('not performs autoReload after cancelling by cancelAutoReload', () {
        fakeAsync((async) {
          reloader.startAutoReload();

          async.elapse(testDuration - testDurationLag);

          reloader.cancelAutoReload();

          async.elapse(testDuration);

          verifyNever(reloader.autoReload());
        });
      });
    });
  });
}
