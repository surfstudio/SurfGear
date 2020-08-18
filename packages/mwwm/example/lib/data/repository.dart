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

import 'package:flutter/foundation.dart';
import 'package:mwwm_github_client/data/owner.dart';

class Repository {
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
