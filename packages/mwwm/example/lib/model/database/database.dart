import 'package:moor_flutter/moor_flutter.dart';
import 'package:mwwm_github_client/model/database/table/tables.dart';
import 'package:mwwm_github_client/model/service/response/reponses.dart';

part 'database.g.dart';

@UseMoor(
  tables: [FavoritesRepoTable, OwnerTable],
  daos: [RepoDao],
)
class Database extends _$Database {
  Database() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite')){
  }

  @override
  int get schemaVersion => 1;

  Future resetDb() async {
    for (var table in allTables) {
      await delete(table).go();
    }
  }

//  @override
//  MigrationStrategy get migration =>
//      MigrationStrategy(onUpgrade: (migrator, from, to) async {
//        if (from == 2) {
//          await migrator.addColumn(
//              favoritesRepoTable, favoritesRepoTable.ownerId);
//          await migrator.createTable(ownerTable);
//        }
//      }, beforeOpen: (details) async {
//        await customStatement('PRAGMA foreign_keys = ON');
//      });
}

@UseDao(
  tables: [FavoritesRepoTable, OwnerTable],
//  queries: {
//    'getReposByName': 'select * from favoritesRepoTable where name = \'test\'; '
//  },
)
class RepoDao extends DatabaseAccessor<Database> with _$RepoDaoMixin {
  RepoDao(Database attachedDatabase) : super(attachedDatabase);

  Future<List<FavoritesRepoTableData>> get getRepos =>
      select(favoritesRepoTable).get();

  Future<List<Repo>> get getReposWithOwner => select(favoritesRepoTable)
      .join([
        leftOuterJoin(
          ownerTable,
          ownerTable.id.equalsExp(favoritesRepoTable.ownerId),
        ),
      ])
      .get()
      .then((value) => value.map((e) {
            var repoData = e.readTable(favoritesRepoTable);
            var ownerData = e.readTable(ownerTable);

            return Repo.fromJson(repoData.toJson())
              ..owner = Owner.fromJson(ownerData.toJson());
          }).toList());

  Future insertRepo(
    FavoritesRepoTableData repoData,
    OwnerTableData ownerData,
  ) async {
    await into(favoritesRepoTable).insert(repoData);
//    await into(ownerTable).insert(ownerData);
  }

  Future updateRepo(
    FavoritesRepoTableData repoData,
    OwnerTableData ownerData,
  ) async {
    await update(favoritesRepoTable).replace(repoData);
//    await update(ownerTable).replace(ownerData);
  }

  Future deleteRepo(FavoritesRepoTableData data) =>
      delete(favoritesRepoTable).delete(data);
}
