import 'package:moor_flutter/moor_flutter.dart';
import 'package:mwwm_github_client/model/database/table/tables.dart';
import 'package:mwwm_github_client/model/repository/response/responses.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'dart:io';
part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(
  tables: [FavoritesRepoTable, OwnerTable],
  daos: [RepoDao],
)
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

@UseDao(
  tables: [
    FavoritesRepoTable,
    OwnerTable,
  ],
)
class RepoDao extends DatabaseAccessor<Database> with _$RepoDaoMixin {
  RepoDao(Database attachedDatabase) : super(attachedDatabase);

  Future<List<Repo>> get getAllRepos => select(favoritesRepoTable)
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

  Future<List<Repo>> getRepoByName(String name) async {
    final query = select(favoritesRepoTable)..where((t) => t.name.equals(name));

    return query
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
  }

  Future insertRepo(
    FavoritesRepoTableData repoData,
    OwnerTableData ownerData,
  ) async {
    await into(favoritesRepoTable).insert(repoData);
    await into(ownerTable).insert(ownerData);
  }

  Future updateRepo(
    FavoritesRepoTableData repoData,
    OwnerTableData ownerData,
  ) async {
    await update(favoritesRepoTable).replace(repoData);
    await update(ownerTable).replace(ownerData);
  }

  Future deleteRepo(
    FavoritesRepoTableData data,
    OwnerTableData ownerData,
  ) async {
    await delete(favoritesRepoTable).delete(data);
    await delete(ownerTable).delete(ownerData);
  }
}
