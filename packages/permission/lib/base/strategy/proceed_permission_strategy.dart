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

import 'package:permission/base/permission_manager.dart';

/// Base class for proceed request permission.
// ignore: one_member_abstracts
abstract class ProceedPermissionStrategy {
  /// Method for proceed request permission.
  Future<void> proceed(Permission permission, PermissionStrategyStatus status);
}

/// Status of permission for proceed in strategy
enum PermissionStrategyStatus {
  /// User allow this permission
  allow,

  /// User deny this permission once or permanent deny not checked
  deny,

  /// User deny this permission with "Don't ask me" or deny on iOs
  permanentDeny,
}
