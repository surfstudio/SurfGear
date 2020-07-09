import 'package:moor_flutter/moor_flutter.dart';

class FavoritesRepoTable extends Table {
  IntColumn get id => integer().named('id').customConstraint('UNIQUE')();

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get nodeId => text().nullable().named('nodeId')();

  TextColumn get name => text().nullable().named('name')();

  TextColumn get fullName => text().nullable().named('fullName')();

  IntColumn get ownerId => integer()
      .named('ownerId')
      .nullable()
      .customConstraint('NULLABLE REFERENCES ownertable(id)')();

  BoolColumn get private => boolean().nullable().named('private')();

  TextColumn get htmlUrl => text().nullable().named('htmlUrl')();

  TextColumn get description => text().nullable().named('description')();

  BoolColumn get fork => boolean().nullable().named('fork')();

  TextColumn get url => text().nullable().named('url')();

  TextColumn get createdAt => text().nullable().named('createdAt')();

  TextColumn get updatedAt => text().nullable().named('updatedAt')();

  TextColumn get pushedAt => text().nullable().named('pushedAt')();

  TextColumn get homepage => text().nullable().named('homepage')();

  IntColumn get size => integer().nullable().named('size')();

  IntColumn get stargazersCount =>
      integer().nullable().named('stargazersCount')();

  IntColumn get watchersCount => integer().nullable().named('watchersCount')();

  TextColumn get language => text().nullable().named('language')();

  IntColumn get forksCount => integer().nullable().named('forksCount')();

  IntColumn get openIssuesCount =>
      integer().nullable().named('openIssuesCount')();

  TextColumn get masterBranch => text().nullable().named('masterBranch')();

  TextColumn get defaultBranch => text().nullable().named('defaultBranch')();

  RealColumn get score => real().nullable().named('score')();
}

class OwnerTable extends Table {
  IntColumn get id => integer().named('id').customConstraint('UNIQUE')();

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get login => text().nullable().named('login')();

  TextColumn get nodeId => text().nullable().named('nodeId')();

  TextColumn get avatarUrl => text().nullable().named('avatarUrl')();

  TextColumn get gravatarId => text().nullable().named('gravatarId')();

  TextColumn get url => text().nullable().named('url')();

  TextColumn get receivedEventsUrl =>
      text().nullable().named('receivedEventsUrl')();

  TextColumn get type => text().nullable().named('type')();
}
