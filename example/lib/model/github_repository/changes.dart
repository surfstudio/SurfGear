import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';

/// Search github repositories by query [query]
class SearchRepositories extends FutureChange<List<Repository>> {
  final String query;

  SearchRepositories(this.query);
}

/// Get all repositories.
class GetRepositories extends FutureChange<List<Repository>> {}
