import 'package:dio/dio.dart' as dio;
import 'package:network/src/base/interceptors/interceptor.dart';

/// Interceptor for dio library
abstract class DioInterceptor
    implements Interceptor<dio.RequestOptions, dio.Response, dio.DioError> {}

/// Wrapper over [DioInterceptor]
class DioInterceptorWrapper extends DioInterceptor {
  final dio.InterceptorSendCallback requestCallback;
  final dio.InterceptorSuccessCallback responseCallback;
  final dio.InterceptorErrorCallback errorCallback;

  DioInterceptorWrapper({
    this.requestCallback,
    this.responseCallback,
    this.errorCallback,
  });

  @override
  onRequest(dio.RequestOptions options) => requestCallback?.call(options);

  @override
  onResponse(dio.Response response) => responseCallback?.call(response);

  @override
  onError(dio.DioError err) => errorCallback?.call(err);
}

/// decorator for [dio.Interceptor]
class DioInterceptorDecorator implements dio.Interceptor {
  final DioInterceptor _interceptor;

  DioInterceptorDecorator(this._interceptor);

  @override
  onRequest(dio.RequestOptions options) => _interceptor.onRequest(options);

  @override
  onResponse(dio.Response response) => _interceptor.onResponse(response);

  @override
  onError(dio.DioError err) => _interceptor.onError(err);
}
