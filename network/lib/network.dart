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

library network;

///base
export 'package:network/src/base/config.dart';
export 'package:network/src/base/error/http_codes.dart';
export 'package:network/src/base/error/http_exceptions.dart';
export 'package:network/src/base/headers.dart';
export 'package:network/src/base/http.dart';
export 'package:network/src/base/response.dart';
export 'package:network/src/base/status_mapper.dart';

///implementations
export 'package:network/src/impl/default/default_http.dart';
export 'package:network/src/impl/dio/dio_http.dart';

///rx support
export 'package:network/src/rx/rx_http.dart';
export 'package:network/src/rx/rx_http_delegate.dart';
