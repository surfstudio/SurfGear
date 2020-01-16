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

import 'dart:io';

import 'package:network/src/base/response.dart';
import 'package:rxdart/rxdart.dart';

///Фасад над работой с сетью с использование [rx]
abstract class RxHttp {
  ///GET- request
  Observable<Response> get<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  ///POST-request
  Observable<Response> post<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  });

  ///PUT -request
  Observable<Response> put<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  });

  ///DELETE -request
  Observable<Response> delete<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  ///PATCH -request
  Observable<Response> patch<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  });

  ///HEAD - request
  Observable<Response> head<T>(
    String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
  );

  /// Multipart request
  Observable<Response> multipart<T>(
    String url, {
    Map<String, String> headers,
    File body,
  });
}
