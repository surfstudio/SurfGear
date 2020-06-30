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

library permission;

export 'package:permission/base/strategy/proceed_permission_strategy.dart';
export 'package:permission/base/strategy/deny_resolve_strategy_storage.dart';
export 'package:permission/base/permission_manager.dart';
export 'package:permission/base/exceptions.dart';

export 'package:permission/impl/strategy/proceed_permission_strategy_example.dart';
export 'package:permission/impl/strategy/default_proceed_permission_strategy_storage.dart';
export 'package:permission/impl/default_permission_manager.dart';
