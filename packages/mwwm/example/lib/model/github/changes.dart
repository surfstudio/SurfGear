import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/owner.dart';
import 'package:mwwm_github_client/data/repository.dart';

/// Search github repositories by query [query]
class SearchRepositories extends FutureChange<List<Repository>> {
  SearchRepositories(this.query);

  final String query;
}

/// Get all repositories.
class GetRepositories extends FutureChange<List<Repository>> {}

/// Get All Users
class GetUsers extends FutureChange<List<Owner>> {}
