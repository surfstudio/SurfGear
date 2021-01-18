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

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_rate/exception.dart';

/// Channel
const String channelName = 'in_app_rate';

/// Methods
const String openRatingDialogMethod = 'openRatingDialog';

/// Arguments
const _isTestEnvironment = 'isTestEnvironment';

class InAppRate {
  static const _channel = MethodChannel(channelName);

  /// Show rating dialog to user
  ///
  /// [isTest] Replace manager with fake manager, only Android
  /// [onError] Callback on nativeError,
  /// you could open link to application store
  static Future<bool?> openRatingDialog({
    bool isTest = false,
    VoidCallback? onError,
  }) {
    return _channel.invokeMethod<bool>(
      openRatingDialogMethod,
      {_isTestEnvironment: isTest},
    ).catchError(
      // ignore: avoid_types_on_closure_parameters
      (Object? error) {
        if (onError != null) {
          onError();
          return false;
        }
        Platform.isAndroid
            ? throw PlayServiceNotEnabled()
            : throw IOSVersionIsLow();
      },
    );
  }
}
