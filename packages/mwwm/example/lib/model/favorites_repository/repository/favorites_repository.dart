import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites_repository/database/database.dart';
import 'package:mwwm_github_client/model/github_repository/repository/dto/owner_dto.dart';
import 'package:mwwm_github_client/model/github_repository/repository/dto/repository_dto.dart';

class FavoritesRepository {
  FavoritesRepository(Database db) {
    _db = db;
    _dao = db.repoDao;
  }

  final List<Repository> _favoritesList = [];
  Database _db;
  RepoDao _dao;

  Future<List<Repository>> add(Repository r) async {
    _favoritesList.add(r);
    return _favoritesList;
  }

  Future<List<Repository>> delete(Repository r) async {
    _favoritesList.remove(r);
    return _favoritesList;
  }

  Future<List<Repository>> getAllRepos() async {
    return _dao.getAllRepos;
  }

  Future<List<Repository>> getByName(String name) async {
    return _dao.getRepoByName(name);
  }

  Future insertRepo(Repository data) {
    final repoData = FavoritesRepoTableData.fromData(
      RepositoryDto(data).toJson(),
      _db,
    );
    final ownerData = OwnerTableData.fromData(
      OwnerDto(data.owner).toJson(),
      _db,
    );

    return _dao.insertRepo(repoData, ownerData);
  }

  Future updateRepo(Repository data) {
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

  Future deleteRepo(Repository data) {
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
}
