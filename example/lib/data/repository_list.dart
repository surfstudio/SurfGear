import 'package:mwwm_github_client/data/repository.dart';

class RepositoryList {
  int totalCount;
  bool incompleteResults;
  List<Repository> items;

  RepositoryList({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  @override
  String toString() => {
        'totalCount': totalCount,
        'incompleteResults': incompleteResults,
        'items': items,
      }.toString();
}
