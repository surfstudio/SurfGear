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

class LogConfig {
  /// Print request options
  final bool options;

  /// Print request header
  final bool requestHeader;

  /// Print request data
  final bool requestBody;

  /// Print
  final bool responseBody;

  /// Print
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// Log size per print
  final int logSize;

  LogConfig({
    this.options = false,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseBody = true,
    this.responseHeader = true,
    this.error = true,
    this.logSize = 2048,
  });
}
