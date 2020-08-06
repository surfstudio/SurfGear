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

import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/auth/repository/auth_repository.dart';
import 'package:mwwm_github_client/model/common/network/auth_network_client.dart';
import 'package:mwwm_github_client/model/favorites/database/database.dart';
import 'package:mwwm_github_client/model/favorites/repository/favorites_repository.dart';
import 'package:mwwm_github_client/model/github/repository/github_repository.dart';
import 'package:mwwm_github_client/ui/app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider(
      create: (_) => Database(),
      child: MultiProvider(
        providers: [
          Provider(
            create: (context) => AuthNetworkClient(),
          ),
          Provider(
            create: (context) => AuthRepository(
              context.read<AuthNetworkClient>(),
            ),
          ),
          Provider(
            create: (context) => WidgetModelDependencies(
              errorHandler: DefaultErrorHandler(),
            ),
          ),
          Provider(
            create: (context) => GithubRepository(
              context.read<AuthNetworkClient>(),
            ),
          ),
          Provider(
            create: (context) => FavoritesRepository(Database()),
          ),
        ],
        child: App(),
      ),
    ),
  );
}

/// Log errors
class DefaultErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint(e.toString());
  }
}
