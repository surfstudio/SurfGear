import 'package:flutter/cupertino.dart';

class RepoList {
  int totalCount;
  bool incompleteResults;
  List<Repo> items;

  RepoList({this.totalCount, this.incompleteResults, this.items});

  RepoList.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = <Repo>[];
      json['items'].forEach((v) {
        items.add(Repo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['incomplete_results'] = incompleteResults;
    if (items != null) {
      data['items'] = items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Repo {
  int id;
  String nodeId;
  String name;
  String fullName;
  Owner owner;
  bool private;
  String htmlUrl;
  String description;
  bool fork;
  String url;
  String createdAt;
  String updatedAt;
  String pushedAt;
  String homepage;
  int size;
  int stargazersCount;
  int watchersCount;
  String language;
  int forksCount;
  int openIssuesCount;
  String masterBranch;
  String defaultBranch;
  double score;

  bool isFavorite;

  Repo({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    @required this.owner,
    this.private,
    this.htmlUrl,
    this.description,
    this.fork,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.homepage,
    this.size,
    this.stargazersCount,
    this.watchersCount,
    this.language,
    this.forksCount,
    this.openIssuesCount,
    this.masterBranch,
    this.defaultBranch,
    this.score,
    bool isFavorite,
  }) : isFavorite = isFavorite ?? false;

  Repo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    name = json['name'] ?? '';
    fullName = json['full_name'] ?? '';
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    private = json['private'];
    htmlUrl = json['html_url'];
    description = json['description'];
    fork = json['fork'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pushedAt = json['pushed_at'];
    homepage = json['homepage'];
    size = json['size'];
    stargazersCount = json['stargazers_count'];
    watchersCount = json['watchers_count'];
    language = json['language'];
    forksCount = json['forks_count'];
    openIssuesCount = json['open_issues_count'];
    masterBranch = json['master_branch'];
    defaultBranch = json['default_branch'];
    score = json['score'];

    isFavorite = false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['node_id'] = nodeId;
    data['name'] = name;
    data['full_name'] = fullName;
    if (owner != null) {
      data['owner'] = owner.toJson();
      data['ownerId'] = owner.id;
    }
    data['private'] = private;
    data['html_url'] = htmlUrl;
    data['description'] = description;
    data['fork'] = fork;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pushed_at'] = pushedAt;
    data['homepage'] = homepage;
    data['size'] = size;
    data['stargazers_count'] = stargazersCount;
    data['watchers_count'] = watchersCount;
    data['language'] = language;
    data['forks_count'] = forksCount;
    data['open_issues_count'] = openIssuesCount;
    data['master_branch'] = masterBranch;
    data['default_branch'] = defaultBranch;
    data['score'] = score;

    isFavorite = false;
    return data;
  }

  @override
  String toString() {
    return 'Repo{id: $id, nodeId: $nodeId, name: $name, fullName: $fullName, owner: $owner, private: $private, htmlUrl: $htmlUrl, description: $description, fork: $fork, url: $url, createdAt: $createdAt, updatedAt: $updatedAt, pushedAt: $pushedAt, homepage: $homepage, size: $size, stargazersCount: $stargazersCount, watchersCount: $watchersCount, language: $language, forksCount: $forksCount, openIssuesCount: $openIssuesCount, masterBranch: $masterBranch, defaultBranch: $defaultBranch, score: $score}';
  }
}

class Owner {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String receivedEventsUrl;
  String type;

  Owner(
      {this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.receivedEventsUrl,
      this.type});

  Owner.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['avatar_url'] = avatarUrl;
    data['gravatar_id'] = gravatarId;
    data['url'] = url;
    data['received_events_url'] = receivedEventsUrl;
    data['type'] = type;
    return data;
  }

  @override
  String toString() {
    return 'Owner{login: $login, id: $id, nodeId: $nodeId, avatarUrl: $avatarUrl, gravatarId: $gravatarId, url: $url, receivedEventsUrl: $receivedEventsUrl, type: $type}';
  }
}
