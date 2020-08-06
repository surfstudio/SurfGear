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

import 'package:logger/logger.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/network.dart';

///Базовый класс для обработки ошибок, связанных с сервисным слоем
abstract class NetworkErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    Exception exception;

    if (e is Error) {
      exception = Exception(e.stackTrace);
    } else if (e is Exception) {
      exception = e;
      Logger.d('NetworkErrorHandler handle error', exception);

      if (exception is ConversionException) {
        handleConversionError(exception);
      } else if (exception is NoInternetException) {
        handleNoInternetError(exception);
      } else if (exception is HttpProtocolException) {
        handleHttpProtocolException(exception);
      } else {
        handleOtherError(exception);
      }
    }
  }

  void handleConversionError(ConversionException e);

  void handleNoInternetError(NoInternetException e);

  void handleHttpProtocolException(HttpProtocolException e);

  void handleOtherError(Exception e);
}
