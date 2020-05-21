import 'package:mwwm_github_client/interactor/repository/favorites_repository.dart';
import 'package:mwwm_github_client/model/service/response/reponses.dart';

class FavoritesInteractor {
  FavoritesRepository repository = FavoritesRepository();

  Future<List<Repo>> getAllRepos() => repository.getAllRepos();

  Future<List<Repo>> getByName(String name) => repository.getByName(name);

  Future insertRepo(Repo data) => repository.insertRepo(data);

  Future updateRepo(Repo data) => repository.updateRepo(data);

  Future deleteRepo(Repo data) => repository.deleteRepo(data);
}
