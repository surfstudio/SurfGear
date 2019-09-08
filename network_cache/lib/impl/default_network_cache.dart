import 'package:network_cache/base/cache_strategy.dart';
import 'package:network_cache/base/network_cache.dart';
import 'package:network_cache/domain/response_entity.dart';
import 'package:network_cache/network_cache.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storage/storage.dart';
import 'package:network/network.dart';

/// Default implementation based on json storage
class DefaultNetworkCache implements NetworkCache {
  final Storage<String, Map<String, dynamic>> _storage;
  final RxHttp _http;
  final CacheStrategy _strategy;
  final Duration lifetime;

  DefaultNetworkCache(
    this._storage,
    this._http, {
    CacheStrategy strategy,
    this.lifetime = const Duration(hours: 12),
  })  : _strategy = strategy ?? CacheIfErrorStrategy(),
        assert(_storage != null),
        assert(_http != null),
        assert(lifetime != null);

  @override
  void clearCache() => _storage.clear();

  @override
  Observable<Response> hybridGet(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Duration lifetime,
  }) {
    final key = _buildStorageKey(url, query);
    final cacheResponse = Observable.fromFuture(_storage.get(key))
        .map((data) => _extractResponse(data, key))
        .where((data) => data != null);

    final networkResponse = _http
        .get(url, query: query, headers: headers)
        .doOnData((data) => _writeCache(key, data, lifetime ?? this.lifetime));

    final resolvedResponse = _strategy.resolve(cacheResponse, networkResponse);

    return resolvedResponse;
  }

  Response _extractResponse(Map<String, dynamic> entityJson, String key) {
    if (entityJson == null) return null;

    final entity = ResponseEntity.fromJson(entityJson);
    final actualAlive = DateTime.now().difference(entity.storageTimestamp);
    final cacheExpired = actualAlive.compareTo(entity.lifetime) >= 0;

    if (cacheExpired) {
      _storage.remove(key);
      return null;
    }

    return Response(entity._data, 200);
  }

  void _writeCache(String key, Response response, Duration lifetime) {
    if (response.statusCode ~/ 100 == 2 && response.body.isNotEmpty) {
      final entity = ResponseEntity(
        _data: response.body,
        lifetime: lifetime,
        storageTimestamp: DateTime.now(),
      );

      _storage.put(key, entity.toJson());
    }
  }

  String _buildStorageKey(String url, Map<String, dynamic> query) {
    String buildParam(String param, dynamic value) =>
        "$param=" + value?.toString() ?? "";

    StringBuffer buffer = StringBuffer(url);

    if (query == null || query.isEmpty) return buffer.toString();

    final params = query.entries;

    buffer.write("?");
    buffer.write(buildParam(params.first.key, params.first.value));

    for (var param in params.skip(1)) {
      buffer.write("&");
      buffer.write(buildParam(param.key, param.value));
    }

    return buffer.toString();
  }
}
