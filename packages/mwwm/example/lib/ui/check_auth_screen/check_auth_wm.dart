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
import 'package:mwwm_github_client/model/auth/changes.dart';
import 'package:mwwm_github_client/ui/login_screen/login_screen_route.dart';
import 'package:mwwm_github_client/ui/main_screen/main_screen_route.dart';

/// widget model checks authorization
class CheckAuthWm extends WidgetModel {
  CheckAuthWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    this.navigator,
  ) : super(
          baseDependencies,
          model: model,
        );

  final NavigatorState navigator;

  @override
  void onLoad() {
    super.onLoad();
    _auth();
  }

  void _auth() {
    doFuture<bool>(
      _checkAuth(),
      (isUserAuth) async {
        if (isUserAuth) {
          await navigator.push(MainScreenRoute());
        } else {
          await navigator.push(
            LoginScreenRoute(
              argument1: 'hello',
              argument2: 42,
            ),
          );
        }
      },
      onError: handleError,
    );
  }

  Future<bool> _checkAuth() {
    return model.perform(IsUserAuthorize());
  }
}
