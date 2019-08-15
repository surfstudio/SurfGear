import 'package:network/network.dart';
import 'package:network_cache/base/cache_strategy.dart';
import 'package:rxdart/rxdart.dart';

/// Emits cache response first, network response later.
class CacheFirstStrategy implements CacheStrategy {
  @override
  Observable<Response> resolve(
    Observable<Response> cacheResponse,
    Observable<Response> networkResponse,
  ) =>
      Observable.concatEager([
        cacheResponse,
        networkResponse,
      ]);
}

/// Emits cache response, if it doesn't exist emits network response.
class CacheIfExistsStrategy implements CacheStrategy {
  @override
  Observable<Response> resolve(
    Observable<Response> cacheResponse,
    Observable<Response> networkResponse,
  ) =>
      cacheResponse.switchIfEmpty(networkResponse);
}

class CacheIfErrorStrategy implements CacheStrategy {
  @override
  Observable<Response> resolve(
    Observable<Response> cacheResponse,
    Observable<Response> networkResponse,
  ) =>
      networkResponse.onErrorResume(
        (e) => Observable.concat([
          cacheResponse,
          Observable.error(e),
        ])
      );
}
