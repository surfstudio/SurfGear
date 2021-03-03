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

import 'package:mwwm_github_client/data/owner.dart';
import 'package:mwwm_github_client/utils/json_extensions.dart';

class OwnerDto {
  OwnerDto(this.owner);

  OwnerDto.fromJson(Map<String, dynamic> json)
      : owner = Owner(
          login: json.get<String>('login'),
          id: json.get<int>('id'),
          nodeId: json.get<String>('node_id'),
          avatarUrl: json.get<String>('avatar_url'),
          gravatarId: json.get<String>('gravatar_id'),
          url: json.get<String>('url'),
          receivedEventsUrl: json.get<String>('received_events_url'),
          type: json.get<String>('type'),
        );

  final Owner owner;

  Owner get data => owner;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = owner.login;
    data['id'] = owner.id;
    data['node_id'] = owner.nodeId;
    data['avatar_url'] = owner.avatarUrl;
    data['gravatar_id'] = owner.gravatarId;
    data['url'] = owner.url;
    data['received_events_url'] = owner.receivedEventsUrl;
    data['type'] = owner.type;
    return data;
  }

  @override
  String toString() => owner.toString();
}
