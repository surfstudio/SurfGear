// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:mwwm_github_client/data/owner.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites/database/table/tables.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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

  Future<List<Repository>> get getAllRepos => select(favoritesRepoTable)
      .join([
        leftOuterJoin(
          ownerTable,
          ownerTable.id.equalsExp(favoritesRepoTable.ownerId),
        ),
      ])
      .get()
      .then(
        (value) => value.map((e) {
          final FavoritesRepoTableData repoData = e.readTable(
            favoritesRepoTable,
          );
          final OwnerTableData ownerData = e.readTable(ownerTable);

          return _getRepository(repoData, ownerData);
        }).toList(),
      );

  Future<List<Repository>> getRepoByName(String name) async {
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
              final FavoritesRepoTableData repoData = e.readTable(
                favoritesRepoTable,
              );
              final OwnerTableData ownerData = e.readTable(ownerTable);

              return _getRepository(repoData, ownerData);
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

Repository _getRepository(
  FavoritesRepoTableData repoData,
  OwnerTableData ownerData,
) {
  final owner = Owner(
    id: ownerData.id,
    login: ownerData.login,
    nodeId: ownerData.nodeId,
    avatarUrl: ownerData.avatarUrl,
    gravatarId: ownerData.gravatarId,
    url: ownerData.url,
    receivedEventsUrl: ownerData.receivedEventsUrl,
    type: ownerData.type,
  );

  return Repository(
    id: repoData.id,
    owner: owner,
    nodeId: repoData.nodeId,
    name: repoData.name,
    fullName: repoData.fullName,
    private: repoData.private,
    htmlUrl: repoData.htmlUrl,
    description: repoData.description,
    fork: repoData.fork,
    url: repoData.url,
    createdAt: repoData.createdAt,
    updatedAt: repoData.updatedAt,
    pushedAt: repoData.pushedAt,
    homepage: repoData.homepage,
    size: repoData.size,
    stargazersCount: repoData.stargazersCount,
    watchersCount: repoData.watchersCount,
    language: repoData.language,
    forksCount: repoData.forksCount,
    openIssuesCount: repoData.openIssuesCount,
    masterBranch: repoData.masterBranch,
    defaultBranch: repoData.defaultBranch,
    score: repoData.score,
    isFavorite: true,
  );
}
