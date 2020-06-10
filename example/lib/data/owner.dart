class Owner {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String avatarId;
  String url;
  String receivedEventsUrl;
  String type;

  Owner({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.avatarId,
    this.url,
    this.receivedEventsUrl,
    this.type,
  });

  @override
  String toString() => {
        'login': login,
        'id': id,
        'nodeId': nodeId,
        'avatarUrl': avatarUrl,
        'gravatarId': avatarId, // TODO check right name
        'url': url,
        'receivedEventsUrl': receivedEventsUrl,
        'type': type,
      }.toString();
}
