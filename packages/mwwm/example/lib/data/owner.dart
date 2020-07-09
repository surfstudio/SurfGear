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
