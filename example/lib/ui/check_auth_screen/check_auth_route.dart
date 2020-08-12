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
import 'package:mwwm_github_client/model/auth/performers.dart';
import 'package:mwwm_github_client/model/auth/repository/auth_repository.dart';
import 'package:mwwm_github_client/ui/check_auth_screen/check_auth_screen.dart';
import 'package:mwwm_github_client/ui/check_auth_screen/check_auth_wm.dart';
import 'package:provider/provider.dart';

/// CheckAuthScreen Route
class CheckAuthRoute extends MaterialPageRoute {
  CheckAuthRoute()
      : super(
          builder: (context) => CheckAuthScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => CheckAuthWm(
      context.read<WidgetModelDependencies>(),
      Model([
        IsUserAuthorizePerformer(
          context.read<AuthRepository>(),
        ),
      ]),
      Navigator.of(context),
    );
