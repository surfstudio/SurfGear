import 'package:dio/dio.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/data/repository_list.dart';
import 'package:mwwm_github_client/model/github/repository/dto/repository_dto.dart';
import 'package:mwwm_github_client/model/github/repository/dto/repository_list_dto.dart';

/// Service for work with Github
/// Wrapper on [Github] library
class GithubRepository {
  final _client = Dio();

  /// Search repository by [name]
  Future<List<Repository>> findRepositories(String name) async {
    if (name.isEmpty) return [];
    final Response<Map<String, dynamic>> response = await _client.get(
      'https://api.github.com/search/repositories?q=$name',
    );
    final RepositoryList repositoryList = RepositoryListDto.fromJson(
      response.data,
    ).data;

    return repositoryList.items;
  }

  /// Get github repositories
  Future<List<Repository>> getRepositories() async {
    final Response<List<dynamic>> response = await _client.get(
      'https://api.github.com/repositories',
    );

    final List<Repository> repositories = response.data
        .map<Repository>(
          (json) => RepositoryDto.fromJson(json as Map<String, dynamic>).data,
        )
        .toList();

    return repositories;
  }
}
