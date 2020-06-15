import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites_repository/database/database.dart';
import 'package:mwwm_github_client/model/github_repository/repository/dto/owner_dto.dart';
import 'package:mwwm_github_client/model/github_repository/repository/dto/repository_dto.dart';

class FavoritesRepository {
  FavoritesRepository(this._db) : _dao = _db.repoDao;

  final Database _db;
  final RepoDao _dao;

  Future<void> add(Repository data) {
    final repoData = FavoritesRepoTableData(
      id: data.id,
      nodeId: data.nodeId,
      name: data.name,
      fullName: data.fullName,
      private: data.private,
      htmlUrl: data.htmlUrl,
      description: data.description,
      fork: data.fork,
      url: data.url,
      ownerId: data.owner.id,
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
    );

    final ownerData = OwnerTableData(
      id: data.owner.id,
      login: data.owner.login,
      nodeId: data.owner.nodeId,
      avatarUrl: data.owner.avatarUrl,
      gravatarId: data.owner.gravatarId,
      url: data.owner.url,
      receivedEventsUrl: data.owner.receivedEventsUrl,
      type: data.owner.type,
    );

    return _dao.insertRepo(repoData, ownerData);
  }

  Future<void> update(Repository data) {
    final repoTableData = FavoritesRepoTableData.fromData(
      RepositoryDto(data).toJson(),
      _db,
    );
    final ownerData = OwnerTableData.fromData(
      OwnerDto(data.owner).toJson(),
      _db,
    );

    return _dao.updateRepo(repoTableData, ownerData);
  }

  Future<void> delete(Repository data) {
    final repoTableData = FavoritesRepoTableData.fromData(
      RepositoryDto(data).toJson(),
      _db,
    );
    final ownerData = OwnerTableData.fromData(
      OwnerDto(data.owner).toJson(),
      _db,
    );

    return _dao.deleteRepo(repoTableData, ownerData);
  }

  Future<List<Repository>> getAllRepos() async {
    return _dao.getAllRepos;
  }

  Future<List<Repository>> getByName(String name) async {
    return _dao.getRepoByName(name);
  }
}
