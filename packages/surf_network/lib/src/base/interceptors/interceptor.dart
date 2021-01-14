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

///  Http instance may have interceptor(s) by which you can intercept
///  requests or responses before they are handled.
///  [RQ] - type of request
///  [RS] - type of response
///  [E] - exception
abstract class Interceptor<RQ, RS, E> {
  /// The callback will be executed before the request is initiated.
  Future onRequest(RQ options);

  /// The callback will be executed on success.
  Future onResponse(RS response);

  /// The callback will be executed on error.
  Future onError(E err);
}
