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
  Future onRequest(dio.RequestOptions options) {
    super.onRequest(options);
    requestCallback?.call(options);
    return Future.value(options);
  }

  @override
  Future onResponse(dio.Response response) {
    super.onResponse(response);
    responseCallback?.call(response);
    return Future.value(response);
  }

  @override
  Future onError(dio.DioError error) {
    super.onError(error);
    errorCallback?.call(error);
    return Future.value(error);
  }
}

/// decorator for [dio.Interceptor]
class DioInterceptorDecorator implements dio.Interceptor {
  final DioInterceptor _interceptor;

  DioInterceptorDecorator(this._interceptor);

  @override
  Future onResponse(dio.Response response) {
    return _interceptor.onResponse(response);
  }

  @override
  Future onError(dio.DioError err) {
    return _interceptor.onError(err);
  }

  @override
  Future onRequest(dio.RequestOptions options) {
    return _interceptor.onRequest(options);
  }
}
