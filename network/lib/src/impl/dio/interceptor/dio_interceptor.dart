import 'package:dio/dio.dart' as dio;
import 'package:network/src/base/interceptors/interceptor.dart';

/// Interceptor for dio library
class DioInterceptor
    extends Interceptor<dio.RequestOptions, dio.Response, dio.DioError> {}

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
  void onRequest(dio.RequestOptions options) {
    super.onRequest(options);
    requestCallback?.call(options);
  }

  @override
  void onResponse(dio.Response response) {
    super.onResponse(response);
    responseCallback?.call(response);
  }

  @override
  void onError(dio.DioError err) {
    super.onError(err);
    errorCallback?.call(err);
  }
}

/// decorator for [dio.Interceptor]
class DioInterceptorDecorator implements dio.Interceptor {
  final DioInterceptor _interceptor;

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
