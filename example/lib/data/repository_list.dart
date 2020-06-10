import 'package:mwwm_github_client/data/repository.dart';

class RepositoryList {
  RepositoryList({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  int totalCount;
  bool incompleteResults;
  List<Repository> items;

  @override
  String toString() => {
        'totalCount': totalCount,
        'incompleteResults': incompleteResults,
        'items': items,
      }.toString();
}
