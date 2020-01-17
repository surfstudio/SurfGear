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
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) {
    final request = http.get(url, headers: headers, query: query);
    return _adapt(request);
  }

  @override
  Observable<Response> post<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) {
    final request = http.post(url, headers: headers, body: body, query: query);
    return _adapt(request);
  }

  @override
  Observable<Response> put<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) {
    final request = http.put(url, headers: headers, body: body, query: query);
    return _adapt(request);
  }

  @override
  Observable<Response> delete<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) {
    final request = http.delete(url, headers: headers, query: query);
    return _adapt(request);
  }

  @override
  Observable<Response> head<T>(
    String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
  ) {
    final request = http.head(url, query, headers);
    return _adapt(request);
  }

  @override
  Observable<Response> patch<T>(
    String url, {
    Map<String, dynamic> query,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) {
    final request = http.patch(url, headers: headers, body: body, query: query);
    return _adapt(request);
  }

  @override
  Observable<Response> multipart<T>(
    String url, {
    Map<String, String> headers,
    File body,
  }) {
    final request = http.multipart(url, headers: headers, body: body);
    return _adapt(request);
  }

  Observable _adapt(Future<Response> deleteRequest) =>
      _callAdapter.adapt(deleteRequest);
}
