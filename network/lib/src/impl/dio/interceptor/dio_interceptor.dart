import 'package:dio/dio.dart' as dio;
import 'package:network/src/base/interceptors/interceptor.dart';

/// decorator for [dio.Interceptor]
class DioInterceptorDecorator implements dio.Interceptor {
  final Interceptor<dio.RequestOptions, dio.Response, dio.DioError>
      _interceptor;

  DioInterceptorDecorator(this._interceptor);

  @override
  void onRequest(dio.RequestOptions options) {
    _interceptor.onRequest(options);
  }

  @override
  void onResponse(dio.Response response) {
    _interceptor.onResponse(response);
  }

  @override
  void onError(dio.DioError err) {
    _interceptor.onError(err);
  }
}
