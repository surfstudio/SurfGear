/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

/// Утилиты для тестирования потоков данных

/// Проверка полученных из [Observable] данных на правду
void expectTrue(Observable<bool> request) => expect(request, emits(true));

/// Проверка полученных из [Observable] данных на null
void expectNotNull(Observable request) => expectTrue(request.map((r) => r != null));

/// Проверка полученного из [Observable] списка на пустоту
void expectNotEmpty(Observable<List> request) => expectTrue(request.map((r) => r.isNotEmpty));
