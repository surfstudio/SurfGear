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
