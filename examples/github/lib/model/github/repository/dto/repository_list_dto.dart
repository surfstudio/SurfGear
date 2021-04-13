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
import 'package:mwwm_github_client/data/repository_list.dart';
import 'package:mwwm_github_client/model/github/repository/dto/repository_dto.dart';
import 'package:mwwm_github_client/utils/json_extensions.dart';

class RepositoryListDto {
  RepositoryListDto(this.repos);

  RepositoryListDto.fromJson(Map<String, dynamic> json)
      : repos = RepositoryList(
          totalCount: json.get<int>('total_count'),
          incompleteResults: json.get<bool>(
            'incomplete_results',
            defaultValue: true,
          ),
          items: json['items'] != null
              ? json.get<List<dynamic>>('items').map<Repository>((json) {
                  return RepositoryDto.fromJson(
                    json as Map<String, dynamic>,
                  ).data;
                }).toList()
              : [],
        );

  final RepositoryList repos;

  RepositoryList get data => repos;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_count'] = repos.totalCount;
    data['incomplete_results'] = repos.incompleteResults;
    if (repos.items != null) {
      data['items'] = repos.items
          .map(
            (repo) => RepositoryDto(repo).toJson(),
          )
          .toList();
    }
    return data;
  }
}
