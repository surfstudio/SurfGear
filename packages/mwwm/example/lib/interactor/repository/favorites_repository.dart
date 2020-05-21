import 'package:mwwm_github_client/model/database/database.dart';
import 'package:mwwm_github_client/model/database/table/tables.dart';
import 'package:mwwm_github_client/model/service/response/reponses.dart';

class FavoritesRepository {
  final db = Database();
  RepoDao dao;

  FavoritesRepository() {
    dao = db.repoDao;
  }

  Future<List<Repo>> getAllRepos() async {
    return dao.getAllRepos;
  }

  Future<List<Repo>> getByName(String name) async {
    return dao.getRepoByName(name);
  }

  Future insertRepo(Repo data) {
    var repoData = FavoritesRepoTableData.fromData(data.toJson(), db);
    var ownerData = OwnerTableData.fromData(data.owner.toJson(), db);

    return dao.insertRepo(repoData, ownerData);
  }

  Future updateRepo(Repo data) {
    var repoTableData = FavoritesRepoTableData.fromData(data.toJson(), db);
    var ownerData = OwnerTableData.fromData(data.owner.toJson(), db);

    return dao.updateRepo(repoTableData, ownerData);
  }

  Future deleteRepo(Repo data) {
    var repoTableData = FavoritesRepoTableData.fromData(data.toJson(), db);
    var ownerData = OwnerTableData.fromData(data.owner.toJson(), db);

    return dao.deleteRepo(repoTableData, ownerData);
  }
}
