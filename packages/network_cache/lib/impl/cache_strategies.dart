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

import 'package:network/surf_network.dart';
import 'package:network_cache/base/cache_strategy.dart';
import 'package:rxdart/rxdart.dart';

/// Emits cache response first, network response later.
class CacheFirstStrategy implements CacheStrategy {
  @override
  Stream<Response> resolve(
    Stream<Response> cacheResponse,
    Stream<Response> networkResponse,
  ) =>
      Rx.concatEager([
        cacheResponse,
        networkResponse,
      ]);
}

/// Emits cache response, if it doesn't exist
/// strategy emits network response.
class CacheIfExistsStrategy implements CacheStrategy {
  @override
  Stream<Response> resolve(
    Stream<Response> cacheResponse,
    Stream<Response> networkResponse,
  ) =>
      cacheResponse.switchIfEmpty(networkResponse);
}

/// Emits network response, if it terminates with an error
/// strategy emits cache and the error.
class CacheIfErrorStrategy implements CacheStrategy {
  @override
  Stream<Response> resolve(
    Stream<Response> cacheResponse,
    Stream<Response> networkResponse,
  ) =>
      // ignore: avoid_types_on_closure_parameters
      networkResponse.onErrorResume((Object e) => Rx.concat([
            cacheResponse,
            Stream.error(e),
          ]));
}
