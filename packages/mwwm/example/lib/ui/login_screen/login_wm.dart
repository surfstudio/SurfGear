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

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/auth/changes.dart';
import 'package:mwwm_github_client/ui/main_screen/main_screen_route.dart';
import 'package:relation/relation.dart';

/// Login screen's widget model
class LoginWm extends WidgetModel {
  LoginWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    this.navigator,
  ) : super(baseDependencies, model: model);

  final loginAction = Action<void>();
  final NavigatorState navigator;

  @override
  void onBind() {
    super.onBind();
    subscribe(
      loginAction.stream,
      (_) {
        doFuture<bool>(
          _login(),
          (isLogin) {
            if (isLogin) {
              navigator.push(MainScreenRoute());
            }
          },
          onError: handleError,
        );
      },
    );
  }

  Future<bool> _login() {
    return model.perform(AuthorizeInGithub());
  }
}
