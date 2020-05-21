import 'package:dio/dio.dart';
import 'package:mwwm_github_client/model/service/response/reponses.dart';

import 'response/reponses.dart';

/// Service for work with Github
/// Wrapper on [Github] library
class GithubRepository {
  final _client = Dio();

  Future<List<Repo>> getRepos(String name) async {
    if (name.isEmpty) return [];
    var resp = await _client.get<Map<String, dynamic>>(
        'https://api.github.com/search/repositories?q=$name');
    var repoResp = RepoList.fromJson(resp.data);
    return repoResp.items;
  }
}
