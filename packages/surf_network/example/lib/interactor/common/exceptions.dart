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

class MessagedException implements Exception {
  final String? message;

  MessagedException(this.message);

  String toString() {
    if (message == null) return "$runtimeType";
    return "$runtimeType: $message";
  }
}

/// Ошибка с требованием подтвердить по смс
class OtpException implements Exception {}

/// Ошибка с отсутсвия юзера
class UserNotFoundException implements Exception {}

/// Ошибка: ответ не найден
class NotFoundException extends MessagedException {
  NotFoundException(String? message) : super(message);
}
