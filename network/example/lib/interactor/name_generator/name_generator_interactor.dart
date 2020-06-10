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

import 'package:name_generator/domain/User.dart';
import 'package:name_generator/interactor/name_generator/repository/name_generator_repository.dart';
import 'package:rxdart/rxdart.dart';

class NameGeneratorInteractor {
  final NameGeneratorRepository _repository;

  NameGeneratorInteractor(this._repository);

  /// Получение параметров пользователя
  Stream<User> getCard() => _repository.getUser();
}
