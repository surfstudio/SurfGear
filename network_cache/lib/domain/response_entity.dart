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

/// Cached data representation
/// with some additional info like recording time.
class ResponseEntity {
  final Map<String, dynamic> data;
  final Duration lifetime;
  final DateTime storageTimestamp;

  ResponseEntity({
    this.data,
    this.lifetime,
    this.storageTimestamp,
  });

  static ResponseEntity fromJson(Map<String, dynamic> json) {
    return ResponseEntity(
      data: Map<String, dynamic>.from(json['data']),
      lifetime: Duration(milliseconds: json['lifetime'] as int),
      storageTimestamp:
          DateTime.fromMillisecondsSinceEpoch(json['storageTimestamp'] as int),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data,
        'lifetime': lifetime.inMilliseconds,
        'storageTimestamp': storageTimestamp.millisecondsSinceEpoch,
      };
}
