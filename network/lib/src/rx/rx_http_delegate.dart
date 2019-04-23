import 'package:network/network.dart';
import 'package:network/src/base/response.dart';
import 'package:network/src/rx/rx_call_adapter.dart';
import 'package:network/src/rx/rx_http.dart';
import 'package:rxdart/rxdart.dart';

///Http делагат, который адаптирует [Http] к [RxHttp]
class RxHttpDelegate implements RxHttp {
  final RxCallAdapter _callAdapter = RxCallAdapter<Response>();

  final Http http;

  RxHttpDelegate(this.http);

  @override
  Observable<Response> get<T>(
    String url, {
    Map<String, String> headers,
  }) {
    final request = http.get(url, headers: headers);
    return _adapt(request);
  }

  @override
  Observable<Response> post<T>(
    String url, {
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) {
    final request = http.post(url, headers: headers, body: body);
    return _adapt(request);
  }

  @override
  Observable<Response> put<T>(
    String url, {
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) {
    final request = http.put(url, headers: headers, body: body);
    return _adapt(request);
  }

  @override
  Observable<Response> delete<T>(
    String url, {
    Map<String, String> headers,
  }) {
    final request = http.delete(url, headers: headers);
    return _adapt(request);
  }

  @override
  Observable<Response> head<T>(
    String url,
    Map<String, String> headers,
  ) {
    final request = http.head(url, headers);
    return _adapt(request);
  }

  @override
  Observable<Response> patch<T>(
    String url, {
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) {
    final request = http.patch(url, headers: headers, body: body);
    return _adapt(request);
  }

  Observable _adapt(Future<Response> deleteRequest) =>
      _callAdapter.adapt(deleteRequest);
}
