import 'package:mwwm_github_client/model/database/database.dart';
import 'package:mwwm_github_client/model/database/table/tables.dart';
import 'package:mwwm_github_client/model/service/response/reponses.dart';

class FavoritesRepository {
  final db = Database();
  RepoDao dao;

  FavoritesRepository() {
    dao = db.repoDao;
    test();
  }

  void test() async {
//    var repos = await getAllReposWithOwner();
    var repos = await getAllRepos();
//    print('избранное0 ${repos[0].toString()}');
    await insertRepo(
      Repo(
        id: 1,
        name: 'repo_name_updated_now',
        owner: Owner(
            login: 'owner_login',
            nodeId: 'testid',
            avatarUrl:
                'https://lh3.googleusercontent.com/proxy/OGL6XVA38k_lEs0Ft-7JWjusSRFJB01UGWTaY0qnHE_kD_K9gDWVyRZ_Ua2dJ_O5VbZ5y5ovpfoRlUJUBRVcRkPxHWCAWQSh_jf6HyE'),
        description:
            'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionfdzfsdfdsafsdafsdafsd'
            'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionfdzfsdfdsafsdafsdafsd'
            'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionfdzfsdfdsafsdafsdafsd'
            'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionfdzfsdfdsafsdafsdafsd'
            'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionfdzfsdfdsafsdafsdafsd',
        language: 'language_name',
        stargazersCount: 50,
        watchersCount: 50,
      ),
    );
//    var repos1 = await getAllReposWithOwner();
    var repos1 = await getAllRepos();
    print('избранное0 update ${repos1[0].toString()}');
  }

  Future<List<Repo>> getAllRepos() async {
    var repos = await dao.getRepos;

    return repos
        .map(
          (repoTable) => Repo.fromJson(repoTable.toJson()),
        )
        .toList();
  }

  Future<List<Repo>> getAllReposWithOwner() async {
    return dao.getReposWithOwner;
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
    return dao.deleteRepo(repoTableData);
  }
}
