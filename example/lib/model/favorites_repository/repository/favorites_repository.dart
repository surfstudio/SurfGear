import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites_repository/database/database.dart';
import 'package:mwwm_github_client/model/github_repository/repository/dto/owner_dto.dart';
import 'package:mwwm_github_client/model/github_repository/repository/dto/repository_dto.dart';

class FavoritesRepository {
  FavoritesRepository(this._db) : _dao = _db.repoDao;

  final Database _db;
  final RepoDao _dao;

  Future<void> add(Repository data) {
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

  Future<void> remove(Repository data) {
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
