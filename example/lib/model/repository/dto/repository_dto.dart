import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/repository/dto/owner_dto.dart';

class RepositoryDto {
  final Repository repository;

  RepositoryDto(this.repository);

  Repository get data => repository;

  RepositoryDto.fromJson(Map<String, dynamic> json)
      : repository = Repository(
          id: json['id'],
          nodeId: json['node_id'],
          name: json['name'] ?? '',
          fullName: json['full_name'] ?? '',
          owner: json['owner'] != null
              ? OwnerDto.fromJson(json['owner']).data
              : null,
          private: json['private'],
          htmlUrl: json['html_url'],
          description: json['description'],
          fork: json['fork'],
          url: json['url'],
          createdAt: json['created_at'],
          updatedAt: json['updated_at'],
          pushedAt: json['pushed_at'],
          homepage: json['homepage'],
          size: json['size'],
          stargazersCount: json['stargazers_count'],
          watchersCount: json['watchers_count'],
          language: json['language'],
          forksCount: json['forks_count'],
          openIssuesCount: json['open_issues_count'],
          masterBranch: json['master_branch'],
          defaultBranch: json['default_branch'],
          score: json['score'],
          isFavorite: false,
        );

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
