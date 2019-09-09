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

import 'package:logger/logger.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/network.dart';

///Базовый класс для обработки ошибок, связанных с сервисным слоем
abstract class NetworkErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    if (e is Error) {
      e = Exception((e as Error).stackTrace);
    }
    Logger.d("NetworkErrorHandler handle error", e);
    if (e is ConversionException) {
      handleConversionError(e);
    } else if (e is NoInternetException) {
      handleNoInternetError(e);
    } else if (e is HttpProtocolException) {
      handleHttpProtocolException(e);
    } else {
      handleOtherError(e);
    }
  }

  void handleConversionError(ConversionException e);

  void handleNoInternetError(NoInternetException e);

  void handleHttpProtocolException(HttpProtocolException e);

  void handleOtherError(Exception e);
}
