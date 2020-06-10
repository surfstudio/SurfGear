import 'package:mwwm_github_client/data/owner.dart';

class OwnerDto {
  final Owner owner;

  OwnerDto(this.owner);

  Owner get data => owner;

  OwnerDto.fromJson(Map<String, dynamic> json)
      : owner = Owner(
          login: json['login'],
          id: json['id'],
          nodeId: json['node_id'],
          avatarUrl: json['avatar_url'],
          avatarId: json['gravatar_id'], // TODO check right name
          url: json['url'],
          receivedEventsUrl: json['received_events_url'],
          type: json['type'],
        );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = owner.login;
    data['id'] = owner.id;
    data['node_id'] = owner.nodeId;
    data['avatar_url'] = owner.avatarUrl;
    data['gravatar_id'] = owner.avatarId; // TODO check right name
    data['url'] = owner.url;
    data['received_events_url'] = owner.receivedEventsUrl;
    data['type'] = owner.type;
    return data;
  }

  @override
  String toString() => owner.toString();
}
