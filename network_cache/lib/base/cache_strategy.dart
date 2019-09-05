import 'package:rxdart/rxdart.dart';
import 'package:network/network.dart';

/// Strategy that decides what has to be done with
/// both local and network data sources.
abstract class CacheStrategy {
  Observable<Response> resolve(
    Observable<Response> cacheResponse,
    Observable<Response> networkResponse,
  );
}
