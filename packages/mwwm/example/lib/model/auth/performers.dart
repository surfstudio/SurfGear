import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/auth/changes.dart';
import 'package:mwwm_github_client/model/auth/repository/auth_repository.dart';

/// Authorize github performer
class AuthorizeInGithubPerformer
    extends FuturePerformer<bool, AuthorizeInGithub> {
  AuthorizeInGithubPerformer(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<bool> perform(AuthorizeInGithub change) => _authRepository.auth();
}

class DisconnectGithubPerformer
    extends FuturePerformer<void, DisconnectGithub> {
  DisconnectGithubPerformer(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> perform(DisconnectGithub change) => _authRepository.disconnect();
}

class GetAccessTokenPerformer extends FuturePerformer<String, GetAccessToken> {
  GetAccessTokenPerformer(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<String> perform(GetAccessToken change) => _authRepository.getToken();
}

class IsUserAuthorizePerformer extends FuturePerformer<bool, IsUserAuthorize> {
  IsUserAuthorizePerformer(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<bool> perform(IsUserAuthorize change) => _authRepository.isUserAuth();
}
