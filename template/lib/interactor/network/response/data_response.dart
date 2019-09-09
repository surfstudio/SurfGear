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

import 'package:flutter_template/interactor/base/transformable.dart';

/// Базовая модель респонса для ответов вида: { data: [] }
/// [D] - доменный тип, [T] - Obj
abstract class DataResponse<D, T extends Transformable<D>>
    extends Transformable<List<D>> {
  List<T> _innerData;

  DataResponse.fromJson(Map<String, dynamic> json) {
    var response = json['data'];
    if (response == null) return;

    _innerData = response.map<T>((json) => mapFromJson(json)).toList();
  }

  T mapFromJson(dynamic json);

  @override
  List<D> transform() => _innerData.map<D>((data) => data.transform()).toList();
}
