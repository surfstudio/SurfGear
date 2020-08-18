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

import 'package:dio/dio.dart' as dio;
import 'package:surf_network/src/base/interceptors/interceptor.dart';

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
  dynamic onRequest(dio.RequestOptions options) => requestCallback?.call(options);

  @override
  dynamic onResponse(dio.Response response) => responseCallback?.call(response);

  @override
  dynamic onError(dio.DioError err) => errorCallback?.call(err);
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
