import 'package:mwwm_github_client/data/repository_list.dart';
import 'package:mwwm_github_client/model/github_repository/repository/dto/repository_dto.dart';

class RepositoryListDto {
  final RepositoryList repos;

  RepositoryListDto(this.repos);

  RepositoryList get data => repos;

  RepositoryListDto.fromJson(Map<String, dynamic> json)
      : repos = RepositoryList(
          totalCount: json['total_count'],
          incompleteResults: json['incomplete_results'],
          items: json['items'] != null
              ? json['items'].map((json) {
                  return RepositoryDto.fromJson(json).data;
                }).toList()
              : [],
        );

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
