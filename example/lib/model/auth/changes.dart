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

/// Authorize in github
class AuthorizeInGithub extends FutureChange<bool> {}

/// Disconnect from github
class DisconnectGithub extends FutureChange<void> {}

/// Get access token
class GetAccessToken extends FutureChange<String> {}

/// Check is user auth
class IsUserAuthorize extends FutureChange<bool> {}
