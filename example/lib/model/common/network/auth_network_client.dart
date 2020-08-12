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

import 'package:dio/dio.dart' as d;
import 'package:flutter/services.dart';
import 'package:mwwm_github_client/model/common/network/auth_const.dart';
import 'package:mwwm_github_client/model/common/network/network_client.dart';
import 'package:mwwm_github_client/utils/exceptions.dart';
import 'package:mwwm_github_client/utils/future_extensions.dart';
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_exception.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:http/http.dart' show Response;

/// Http client based on Dio
class AuthNetworkClient implements NetworkClient {
  AuthNetworkClient() {
    _authClient = GitHubOAuth2Client(
      redirectUri: 'my.app://oauth2redirect',
      customUriScheme: 'ru.surf.app',
    );

    _oauth2Helper = OAuth2Helper(
      _authClient,
      clientId: clientId,
      clientSecret: clientSecret,
      scopes: ['repo'],
    );
  }

  OAuth2Client _authClient;

  OAuth2Helper _oauth2Helper;

  /// Authorize on github
  Future<bool> auth() {
    return _oauth2Helper
        .fetchToken()
        .then((response) => response?.tokenType != null ?? false)
        .catchType<Exception>((e) => throw _mapException(e));
  }

  Future<void> disconnect() {
    return _oauth2Helper
        .disconnect()
        .catchType<Exception>((e) => throw _mapException(e));
  }

  /// Get access token
  Future<String> getToken() {
    return _oauth2Helper
        .getToken()
        .then((response) => response.tokenType)
        .catchType<Exception>((e) => throw _mapException(e));
  }

  ///Check is user auth
  Future<bool> isUserAuth() {
    return _oauth2Helper
        .getTokenFromStorage()
        .then((response) => response != null)
        .catchType<Exception>((e) => throw _mapException(e));
  }

  @override
  Future<Response> get(String url) {
    return _oauth2Helper
        .get(url)
        .catchType<Exception>((e) => throw _mapException(e));
  }

  /// Map third party exception to local
  Exception _mapException(Exception e) {
    if (e is PlatformException) {
      if (e.code == 'CANCELED' && e.message == 'User canceled login') {
        return CanceledAuthorizationException();
      }
    }

    if (e is d.DioError) {
      if (e.type == d.DioErrorType.DEFAULT) {
        return NoInternetException(message: e.error.toString());
      }
    }

    if (e is OAuth2Exception) {
      if (e.error == 'incorrect_client_credentials') {
        return IncorrectClientCredentionalsException();
      }
    }

    return e;
  }
}
