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

class Owner {
  Owner({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.receivedEventsUrl,
    this.type,
  });

  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String receivedEventsUrl;
  String type;

  @override
  String toString() => {
        'login': login,
        'id': id,
        'nodeId': nodeId,
        'avatarUrl': avatarUrl,
        'gravatarId': gravatarId,
        'url': url,
        'receivedEventsUrl': receivedEventsUrl,
        'type': type,
      }.toString();
}
