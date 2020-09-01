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

import 'package:flutter/material.dart';
import 'package:name_generator/interactor/name_generator/name_generator_interactor.dart';
import 'package:name_generator/interactor/name_generator/repository/name_generator_repository.dart';
import 'package:name_generator/interactor/network/status_mapper.dart';
import 'package:name_generator/ui/app/app.dart';
import 'package:surf_network/surf_network.dart';

void main() {
  NameGeneratorRepository repository = NameGeneratorRepository(_initHttp());
  NameGeneratorInteractor interactor = NameGeneratorInteractor(repository);

  runApp(App(interactor));
}

RxHttp _initHttp() {
  var dioHttp = DioHttp(
    config: HttpConfig(
      'https://uinames.com/api/?ext',
      Duration(seconds: 30),
    ),
    errorMapper: DefaultStatusMapper(),
    interceptors: _initIntercpetors(),
  );
  return RxHttpDelegate(dioHttp);
}

List<DioInterceptor> _initIntercpetors() {
  return [
    DioInterceptorWrapper(
      requestCallback: (request) =>
          print('onRequest from DioInterceptorWrapper'),
      responseCallback: (response) =>
          print('onResponse from DioInterceptorWrapper'),
      errorCallback: (error) => print('onError from DioInterceptorWrapper'),
    ),
  ];
}
