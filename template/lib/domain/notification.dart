/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

/// Уведомление
class Notification {
  final DateTime date;
  final String title;
  final String text;
  final NotificationType type;

  Notification({
    this.date,
    this.title,
    this.text,
    String type,
  }) : type = _mapToType(type);
}

enum NotificationType { type1, type2 }

NotificationType _mapToType(String type) {
  switch (type) {
    case "type1":
      return NotificationType.type1;

    case "type2":
    default:
      return NotificationType.type2;
  }
}
