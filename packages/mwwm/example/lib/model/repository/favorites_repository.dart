import 'package:mwwm_github_client/model/database/database.dart';
import 'package:mwwm_github_client/model/repository/response/reponses.dart';

class FavoritesRepository {
  Database _db;
  RepoDao _dao;

  FavoritesRepository(Database db) {
    _db = db;
    _dao = db.repoDao;
  }

  Future<List<Repo>> getAllRepos() async {
    return _dao.getAllRepos;
  }

  Future<List<Repo>> getByName(String name) async {
    return _dao.getRepoByName(name);
  }

  Future insertRepo(Repo data) {
    var repoData = FavoritesRepoTableData.fromData(data.toJson(), _db);
    var ownerData = OwnerTableData.fromData(data.owner.toJson(), _db);

    return _dao.insertRepo(repoData, ownerData);
  }

  Future updateRepo(Repo data) {
    var repoTableData = FavoritesRepoTableData.fromData(data.toJson(), _db);
    var ownerData = OwnerTableData.fromData(data.owner.toJson(), _db);

    return _dao.updateRepo(repoTableData, ownerData);
  }

  Future deleteRepo(Repo data) {
    var repoTableData = FavoritesRepoTableData.fromData(data.toJson(), _db);
    var ownerData = OwnerTableData.fromData(data.owner.toJson(), _db);

    return _dao.deleteRepo(repoTableData, ownerData);
  }
}
