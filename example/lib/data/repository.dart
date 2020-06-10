import 'package:flutter/foundation.dart';
import 'package:mwwm_github_client/data/owner.dart';

class Repository {
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

  Repository({
    @required this.owner,
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
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

  @override
  String toString() => {
        'id': id,
        'nodeId': nodeId,
        'name': name,
        'fullName': fullName,
        'private': private,
        'htmlUrl': htmlUrl,
        'description': description,
        'fork': fork,
        'url': url,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'pushedAt': pushedAt,
        'homepage': homepage,
        'size': size,
        'stargazersCount': stargazersCount,
        'watchersCount': watchersCount,
        'language': language,
        'forksCount': forksCount,
        'openIssuesCount': openIssuesCount,
        'masterBranch': masterBranch,
        'defaultBranch': defaultBranch,
        'score': score,
        'isFavorite': isFavorite,
      }.toString();
}
