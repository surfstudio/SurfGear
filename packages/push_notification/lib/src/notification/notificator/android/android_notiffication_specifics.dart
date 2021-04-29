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

/// Android notification settings
class AndroidNotificationSpecifics {
  AndroidNotificationSpecifics({
    this.icon,
    this.channelId,
    this.channelName,
    this.color,
    this.autoCancelable,
  });

  ///Icon drawable
  ///
  /// @mipmap/ic_launcher
  final String? icon;

  /// channelId
  ///
  /// @string/notification_channel_id
  final String? channelId;

  /// Channel name
  ///
  /// @string/notification_channel_name
  final String? channelName;

  /// Icon color
  ///
  /// @color/notification_color
  final String? color;

  /// Notification is auto cancel
  final bool? autoCancelable;

  Map<String, Object?> toMap() {
    return {
      'icon': icon,
      'channelId': channelId,
      'channelName': channelName,
      'color': color,
      'autoCancelable': autoCancelable,
    };
  }
}
