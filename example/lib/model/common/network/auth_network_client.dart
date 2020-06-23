import 'package:mwwm_github_client/model/common/network/auth_const.dart';
import 'package:mwwm_github_client/model/common/network/network_client.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
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
  Future<bool> auth() async {
    try {
      final AccessTokenResponse tokenResponse =
          await _oauth2Helper.fetchToken();

      return tokenResponse.tokenType != null;
    } on Exception catch (e) {
      throw _mapException(e);
    }
  }

  /// Get access token
  Future<String> getToken() async {
    try {
      final AccessTokenResponse tokenResponse = await _oauth2Helper.getToken();

      return tokenResponse.tokenType;
    } on Exception catch (e) {
      throw _mapException(e);
    }
  }

  ///Check is user auth
  Future<bool> isUserAuth() async {
    try {
      final AccessTokenResponse tokenResponse =
          await _oauth2Helper.getTokenFromStorage();

      return tokenResponse.tokenType != null;
    } on Exception catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<Response> get(String url) async {
    try {
      final Response response = await _oauth2Helper.get(url);

      return response;
    } on Exception catch (e) {
      throw _mapException(e);
    }
  }

  /// Map third party exception to local
  Exception _mapException(Exception e) {
    // if (e is DioError) {
    //   if (e.type == DioErrorType.DEFAULT) {
    //     return NoInternetException(message: e.error.toString());
    //   } else {
    //     // map other dio errors
    //   }
    // } else {
    //   // map other exceptions
    // }

    // TODO implement
    
    print(e);
    
    return e;
  }
}
