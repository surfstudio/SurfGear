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

///Коды ошибок
class HttpCodes {
  static final int code200 = 200; //успех
  static final int code304 = 304; //нет обновленных данных
  static final int code401 = 401; //невалидный токен
  static final int code400 = 400; //Bad request
  static final int code403 = 403; // Доступ запрещен
  static final int code404 = 404;
  static final int code500 = 500; //ошибка сервера
  static final int unspecified = -1; //неопределен
}
