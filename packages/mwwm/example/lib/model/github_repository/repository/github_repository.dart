import 'package:dio/dio.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/data/repository_list.dart';
import 'package:mwwm_github_client/model/github_repository/repository/dto/repository_dto.dart';
import 'package:mwwm_github_client/model/github_repository/repository/dto/repository_list_dto.dart';

/// Service for work with Github
/// Wrapper on [Github] library
class GithubRepository {
  final _client = Dio();

  /// Search repository by [name]
  Future<List<Repository>> findRepositories(String name) async {
    if (name.isEmpty) return [];
    Response response = await _client.get<Map<String, dynamic>>(
      'https://api.github.com/search/repositories?q=$name',
    );
    final RepositoryList repositoryList = RepositoryListDto.fromJson(
      response.data,
    ).data;

    return repositoryList.items;
  }

  /// Get github repositories
  Future<List<Repository>> getRepositories() async {
    Response response = await _client.get<List<dynamic>>(
      'https://api.github.com/repositories',
    );

    final List<Repository> repositories = response.data
        .map<Repository>((json) => RepositoryDto.fromJson(json).data)
        .toList();

    return repositories;
  }
}
