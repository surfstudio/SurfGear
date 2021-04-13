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

import 'package:mwwm_github_client/model/common/network/auth_network_client.dart';

/// Github auth repository
class AuthRepository {
  AuthRepository(this._networkClient);

  final AuthNetworkClient _networkClient;

  Future<bool> auth() => _networkClient.auth();

  Future<void> disconnect() => _networkClient.disconnect();

  Future<String> getToken() => _networkClient.getToken();

  Future<bool> isUserAuth() async => _networkClient.isUserAuth();
}
