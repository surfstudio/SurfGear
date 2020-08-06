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

import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/github/repository/dto/owner_dto.dart';
import 'package:mwwm_github_client/utils/json_extensions.dart';

class RepositoryDto {
  RepositoryDto(this.repository);

  RepositoryDto.fromJson(Map<String, dynamic> json)
      : repository = Repository(
          id: json.get<int>('id'),
          nodeId: json.get<String>('node_id'),
          name: json.get<String>('name') ?? '',
          fullName: json.get<String>('full_name') ?? '',
          owner: json['owner'] != null
              ? OwnerDto.fromJson(json.get<Map<String, dynamic>>('owner')).data
              : null,
          private: json.get<bool>('private'),
          htmlUrl: json.get<String>('html_url'),
          description: json.get<String>('description'),
          fork: json.get<bool>('fork'),
          url: json.get<String>('url'),
          createdAt: json.get<String>('created_at'),
          updatedAt: json.get<String>('updated_at'),
          pushedAt: json.get<String>('pushed_at'),
          homepage: json.get<String>('homepage'),
          size: json.get<int>('size'),
          stargazersCount: json.get<int>('stargazers_count'),
          watchersCount: json.get<int>('watchers_count'),
          language: json.get<String>('language'),
          forksCount: json.get<int>('forks_count'),
          openIssuesCount: json.get<int>('open_issues_count'),
          masterBranch: json.get<String>('master_branch'),
          defaultBranch: json.get<String>('default_branch'),
          score: json.get<double>('score'),
          isFavorite: false,
        );

  final Repository repository;

  Repository get data => repository;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = repository.id;
    data['node_id'] = repository.nodeId;
    data['name'] = repository.name;
    data['full_name'] = repository.fullName;
    if (repository.owner != null) {
      data['owner'] = OwnerDto(repository.owner).toJson();
      data['ownerId'] = repository.owner.id;
    }
    data['private'] = repository.private;
    data['html_url'] = repository.htmlUrl;
    data['description'] = repository.description;
    data['fork'] = repository.fork;
    data['url'] = repository.url;
    data['created_at'] = repository.createdAt;
    data['updated_at'] = repository.updatedAt;
    data['pushed_at'] = repository.pushedAt;
    data['homepage'] = repository.homepage;
    data['size'] = repository.size;
    data['stargazers_count'] = repository.stargazersCount;
    data['watchers_count'] = repository.watchersCount;
    data['language'] = repository.language;
    data['forks_count'] = repository.forksCount;
    data['open_issues_count'] = repository.openIssuesCount;
    data['master_branch'] = repository.masterBranch;
    data['default_branch'] = repository.defaultBranch;
    data['score'] = repository.score;
    data['favorite'] = repository.isFavorite;

    return data;
  }

  @override
  String toString() => repository.toString();
}
