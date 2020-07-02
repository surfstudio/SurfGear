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
        .then((response) => response == null || response.tokenType != null)
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
