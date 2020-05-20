import 'package:moor_flutter/moor_flutter.dart';

class FavoritesRepoTable extends Table {
  IntColumn get id => integer().named('id').customConstraint('UNIQUE')();

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get nodeId => text().named('nodeId')();

  TextColumn get name => text().named('name')();

  TextColumn get fullName => text().named('fullName')();

  IntColumn get ownerId => integer()
      .named('ownerId')
      .customConstraint('NULLABLE REFERENCES owner(id)')();

  BoolColumn get private => boolean().named('private')();

  TextColumn get htmlUrl => text().named('htmlUrl')();

  TextColumn get description => text().named('description')();

  BoolColumn get fork => boolean().named('fork')();

  TextColumn get url => text().named('url')();

  TextColumn get createdAt => text().named('createdAt')();

  TextColumn get updatedAt => text().named('updatedAt')();

  TextColumn get pushedAt => text().named('pushedAt')();

  TextColumn get homepage => text().named('homepage')();

  IntColumn get size => integer().named('size')();

  IntColumn get stargazersCount => integer().named('stargazersCount')();

  IntColumn get watchersCount => integer().named('watchersCount')();

  TextColumn get language => text().named('language')();

  IntColumn get forksCount => integer().named('forksCount')();

  IntColumn get openIssuesCount => integer().named('openIssuesCount')();

  TextColumn get masterBranch => text().named('masterBranch')();

  TextColumn get defaultBranch => text().named('defaultBranch')();

  RealColumn get score => real().named('score')();
}

class Owner extends Table {
  IntColumn get id => integer().named('id').customConstraint('UNIQUE')();

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get login => text().named('login')();

  TextColumn get nodeId => text().named('nodeId')();

  TextColumn get avatarUrl => text().named('avatarUrl')();

  TextColumn get url => text().named('url')();

  TextColumn get receivedEventsUrl => text().named('receivedEventsUrl')();

  TextColumn get type => text().named('type')();
}
