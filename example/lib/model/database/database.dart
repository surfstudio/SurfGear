import 'package:moor_flutter/moor_flutter.dart';
import 'package:mwwm_github_client/model/database/table/tables.dart';

part 'database.g.dart';

@UseMoor(tables: [FavoritesRepoTable])
class Database extends _$Database {
  Database() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  @override
  int get schemaVersion => 2;

  Future<List<FavoritesRepoTableData>> get getRepos =>
      select(favoritesRepoTable).get();

  Future insertRepo(FavoritesRepoTableCompanion data) =>
      into(favoritesRepoTable).insert(data);

  Future updateRepo(FavoritesRepoTableCompanion data) =>
      update(favoritesRepoTable).replace(data);

  Future deleteRepo(FavoritesRepoTableCompanion data) =>
      delete(favoritesRepoTable).delete(data);
}
