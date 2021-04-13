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
