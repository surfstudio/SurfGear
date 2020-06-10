import 'package:dio/dio.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/github_repository/repository/dto/repository_list_dto.dart';

/// Service for work with Github
/// Wrapper on [Github] library
class GithubRepository {
  final _client = Dio();

  Future<List<Repository>> getRepos(String name) async {
    if (name.isEmpty) return [];
    var resp = await _client.get<Map<String, dynamic>>(
        'https://api.github.com/search/repositories?q=$name');
    var repoResp = RepositoryListDto.fromJson(resp.data).data;
    return repoResp.items;
  }
}
