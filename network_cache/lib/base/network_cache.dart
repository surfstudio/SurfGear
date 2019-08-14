import 'package:rxdart/rxdart.dart';
import 'package:network/network.dart';

/// Service that incapsulates performing of the network requests 
/// and storage for their responses. 
abstract class NetworkCache {

  /// Get data from local storage or
  /// make network request and save response.
  /// Behavior may be customized with [CacheStrategy]
  Observable<Response> hybridGet(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Duration lifetime,
  });
}
