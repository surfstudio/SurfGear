import 'package:mwwm_github_client/model/database/database.dart';
import 'package:mwwm_github_client/model/database/table/tables.dart';
import 'package:mwwm_github_client/model/service/response/reponses.dart';

class FavoritesRepository {
  final db = Database();

  Future<List<Repo>> getRepos() async {
    var repos = await db.getRepos;

    return repos
        .map(
          (repoTable) => Repo(
            id: repoTable.id,
            nodeId: repoTable.nodeId,
            name: repoTable.name,
            fullName: repoTable.fullName,
//            owner: repoTable.owner,
            private: repoTable.private,
            htmlUrl: repoTable.htmlUrl,
            description: repoTable.description,
            fork: repoTable.fork,
            url: repoTable.url,
            createdAt: repoTable.createdAt,
            updatedAt: repoTable.updatedAt,
            pushedAt: repoTable.pushedAt,
            homepage: repoTable.homepage,
            size: repoTable.size,
            stargazersCount: repoTable.stargazersCount,
            watchersCount: repoTable.watchersCount,
            language: repoTable.language,
            forksCount: repoTable.forksCount,
            openIssuesCount: repoTable.openIssuesCount,
            masterBranch: repoTable.masterBranch,
            defaultBranch: repoTable.defaultBranch,
            score: repoTable.score,
          ),
        )
        .toList();
  }

  Future insertRepo(Repo data) {
    var repoTableCompanion = FavoritesRepoTableCompanion.insert(
      nodeId: data.nodeId,
      name: data.name,
      fullName: data.fullName,
      private: data.private,
      htmlUrl: data.htmlUrl,
      description: data.description,
      fork: data.fork,
      url: data.url,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      pushedAt: data.pushedAt,
      homepage: data.homepage,
      size: data.size,
      stargazersCount: data.stargazersCount,
      watchersCount: data.watchersCount,
      language: data.language,
      forksCount: data.forksCount,
      openIssuesCount: data.openIssuesCount,
      masterBranch: data.masterBranch,
      defaultBranch: data.defaultBranch,
      score: data.score,
      ownerId: null,
    );

    return db.insertRepo(repoTableCompanion);
  }
}
