// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class FavoritesRepoTableData extends DataClass
    implements Insertable<FavoritesRepoTableData> {
  final int id;
  final String nodeId;
  final String name;
  final String fullName;
  final int ownerId;
  final bool private;
  final String htmlUrl;
  final String description;
  final bool fork;
  final String url;
  final String createdAt;
  final String updatedAt;
  final String pushedAt;
  final String homepage;
  final int size;
  final int stargazersCount;
  final int watchersCount;
  final String language;
  final int forksCount;
  final int openIssuesCount;
  final String masterBranch;
  final String defaultBranch;
  final double score;

  FavoritesRepoTableData({
    @required this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.ownerId,
    this.private,
    this.htmlUrl,
    this.description,
    this.fork,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.homepage,
    this.size,
    this.stargazersCount,
    this.watchersCount,
    this.language,
    this.forksCount,
    this.openIssuesCount,
    this.masterBranch,
    this.defaultBranch,
    this.score,
  });

  factory FavoritesRepoTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final doubleType = db.typeSystem.forDartType<double>();
    return FavoritesRepoTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nodeId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nodeId']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      fullName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}fullName']),
      ownerId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}ownerId']),
      private:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}private']),
      htmlUrl:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}htmlUrl']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      fork: boolType.mapFromDatabaseResponse(data['${effectivePrefix}fork']),
      url: stringType.mapFromDatabaseResponse(data['${effectivePrefix}url']),
      createdAt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}createdAt']),
      updatedAt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updatedAt']),
      pushedAt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pushedAt']),
      homepage: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}homepage']),
      size: intType.mapFromDatabaseResponse(data['${effectivePrefix}size']),
      stargazersCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}stargazersCount']),
      watchersCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}watchersCount']),
      language: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}language']),
      forksCount:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}forksCount']),
      openIssuesCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}openIssuesCount']),
      masterBranch: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}masterBranch']),
      defaultBranch: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}defaultBranch']),
      score:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}score']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || nodeId != null) {
      map['nodeId'] = Variable<String>(nodeId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || fullName != null) {
      map['fullName'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || ownerId != null) {
      map['ownerId'] = Variable<int>(ownerId);
    }
    if (!nullToAbsent || private != null) {
      map['private'] = Variable<bool>(private);
    }
    if (!nullToAbsent || htmlUrl != null) {
      map['htmlUrl'] = Variable<String>(htmlUrl);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || fork != null) {
      map['fork'] = Variable<bool>(fork);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || createdAt != null) {
      map['createdAt'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updatedAt'] = Variable<String>(updatedAt);
    }
    if (!nullToAbsent || pushedAt != null) {
      map['pushedAt'] = Variable<String>(pushedAt);
    }
    if (!nullToAbsent || homepage != null) {
      map['homepage'] = Variable<String>(homepage);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<int>(size);
    }
    if (!nullToAbsent || stargazersCount != null) {
      map['stargazersCount'] = Variable<int>(stargazersCount);
    }
    if (!nullToAbsent || watchersCount != null) {
      map['watchersCount'] = Variable<int>(watchersCount);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    if (!nullToAbsent || forksCount != null) {
      map['forksCount'] = Variable<int>(forksCount);
    }
    if (!nullToAbsent || openIssuesCount != null) {
      map['openIssuesCount'] = Variable<int>(openIssuesCount);
    }
    if (!nullToAbsent || masterBranch != null) {
      map['masterBranch'] = Variable<String>(masterBranch);
    }
    if (!nullToAbsent || defaultBranch != null) {
      map['defaultBranch'] = Variable<String>(defaultBranch);
    }
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<double>(score);
    }
    return map;
  }

  FavoritesRepoTableCompanion toCompanion(bool nullToAbsent) {
    return FavoritesRepoTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nodeId:
          nodeId == null && nullToAbsent ? const Value.absent() : Value(nodeId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      ownerId: ownerId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerId),
      private: private == null && nullToAbsent
          ? const Value.absent()
          : Value(private),
      htmlUrl: htmlUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(htmlUrl),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      fork: fork == null && nullToAbsent ? const Value.absent() : Value(fork),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      pushedAt: pushedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(pushedAt),
      homepage: homepage == null && nullToAbsent
          ? const Value.absent()
          : Value(homepage),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      stargazersCount: stargazersCount == null && nullToAbsent
          ? const Value.absent()
          : Value(stargazersCount),
      watchersCount: watchersCount == null && nullToAbsent
          ? const Value.absent()
          : Value(watchersCount),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      forksCount: forksCount == null && nullToAbsent
          ? const Value.absent()
          : Value(forksCount),
      openIssuesCount: openIssuesCount == null && nullToAbsent
          ? const Value.absent()
          : Value(openIssuesCount),
      masterBranch: masterBranch == null && nullToAbsent
          ? const Value.absent()
          : Value(masterBranch),
      defaultBranch: defaultBranch == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultBranch),
      score:
          score == null && nullToAbsent ? const Value.absent() : Value(score),
    );
  }

  factory FavoritesRepoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FavoritesRepoTableData(
      id: serializer.fromJson<int>(json['id']),
      nodeId: serializer.fromJson<String>(json['nodeId']),
      name: serializer.fromJson<String>(json['name']),
      fullName: serializer.fromJson<String>(json['fullName']),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      private: serializer.fromJson<bool>(json['private']),
      htmlUrl: serializer.fromJson<String>(json['htmlUrl']),
      description: serializer.fromJson<String>(json['description']),
      fork: serializer.fromJson<bool>(json['fork']),
      url: serializer.fromJson<String>(json['url']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      pushedAt: serializer.fromJson<String>(json['pushedAt']),
      homepage: serializer.fromJson<String>(json['homepage']),
      size: serializer.fromJson<int>(json['size']),
      stargazersCount: serializer.fromJson<int>(json['stargazersCount']),
      watchersCount: serializer.fromJson<int>(json['watchersCount']),
      language: serializer.fromJson<String>(json['language']),
      forksCount: serializer.fromJson<int>(json['forksCount']),
      openIssuesCount: serializer.fromJson<int>(json['openIssuesCount']),
      masterBranch: serializer.fromJson<String>(json['masterBranch']),
      defaultBranch: serializer.fromJson<String>(json['defaultBranch']),
      score: serializer.fromJson<double>(json['score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nodeId': serializer.toJson<String>(nodeId),
      'name': serializer.toJson<String>(name),
      'fullName': serializer.toJson<String>(fullName),
      'ownerId': serializer.toJson<int>(ownerId),
      'private': serializer.toJson<bool>(private),
      'htmlUrl': serializer.toJson<String>(htmlUrl),
      'description': serializer.toJson<String>(description),
      'fork': serializer.toJson<bool>(fork),
      'url': serializer.toJson<String>(url),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'pushedAt': serializer.toJson<String>(pushedAt),
      'homepage': serializer.toJson<String>(homepage),
      'size': serializer.toJson<int>(size),
      'stargazersCount': serializer.toJson<int>(stargazersCount),
      'watchersCount': serializer.toJson<int>(watchersCount),
      'language': serializer.toJson<String>(language),
      'forksCount': serializer.toJson<int>(forksCount),
      'openIssuesCount': serializer.toJson<int>(openIssuesCount),
      'masterBranch': serializer.toJson<String>(masterBranch),
      'defaultBranch': serializer.toJson<String>(defaultBranch),
      'score': serializer.toJson<double>(score),
    };
  }

  FavoritesRepoTableData copyWith(
          {int id,
          String nodeId,
          String name,
          String fullName,
          int ownerId,
          bool private,
          String htmlUrl,
          String description,
          bool fork,
          String url,
          String createdAt,
          String updatedAt,
          String pushedAt,
          String homepage,
          int size,
          int stargazersCount,
          int watchersCount,
          String language,
          int forksCount,
          int openIssuesCount,
          String masterBranch,
          String defaultBranch,
          double score}) =>
      FavoritesRepoTableData(
        id: id ?? this.id,
        nodeId: nodeId ?? this.nodeId,
        name: name ?? this.name,
        fullName: fullName ?? this.fullName,
        ownerId: ownerId ?? this.ownerId,
        private: private ?? this.private,
        htmlUrl: htmlUrl ?? this.htmlUrl,
        description: description ?? this.description,
        fork: fork ?? this.fork,
        url: url ?? this.url,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pushedAt: pushedAt ?? this.pushedAt,
        homepage: homepage ?? this.homepage,
        size: size ?? this.size,
        stargazersCount: stargazersCount ?? this.stargazersCount,
        watchersCount: watchersCount ?? this.watchersCount,
        language: language ?? this.language,
        forksCount: forksCount ?? this.forksCount,
        openIssuesCount: openIssuesCount ?? this.openIssuesCount,
        masterBranch: masterBranch ?? this.masterBranch,
        defaultBranch: defaultBranch ?? this.defaultBranch,
        score: score ?? this.score,
      );
  @override
  String toString() {
    return (StringBuffer('FavoritesRepoTableData(')
          ..write('id: $id, ')
          ..write('nodeId: $nodeId, ')
          ..write('name: $name, ')
          ..write('fullName: $fullName, ')
          ..write('ownerId: $ownerId, ')
          ..write('private: $private, ')
          ..write('htmlUrl: $htmlUrl, ')
          ..write('description: $description, ')
          ..write('fork: $fork, ')
          ..write('url: $url, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pushedAt: $pushedAt, ')
          ..write('homepage: $homepage, ')
          ..write('size: $size, ')
          ..write('stargazersCount: $stargazersCount, ')
          ..write('watchersCount: $watchersCount, ')
          ..write('language: $language, ')
          ..write('forksCount: $forksCount, ')
          ..write('openIssuesCount: $openIssuesCount, ')
          ..write('masterBranch: $masterBranch, ')
          ..write('defaultBranch: $defaultBranch, ')
          ..write('score: $score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          nodeId.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(
                  fullName.hashCode,
                  $mrjc(
                      ownerId.hashCode,
                      $mrjc(
                          private.hashCode,
                          $mrjc(
                              htmlUrl.hashCode,
                              $mrjc(
                                  description.hashCode,
                                  $mrjc(
                                      fork.hashCode,
                                      $mrjc(
                                          url.hashCode,
                                          $mrjc(
                                              createdAt.hashCode,
                                              $mrjc(
                                                  updatedAt.hashCode,
                                                  $mrjc(
                                                      pushedAt.hashCode,
                                                      $mrjc(
                                                          homepage.hashCode,
                                                          $mrjc(
                                                              size.hashCode,
                                                              $mrjc(
                                                                  stargazersCount
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      watchersCount
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          language
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              forksCount.hashCode,
                                                                              $mrjc(openIssuesCount.hashCode, $mrjc(masterBranch.hashCode, $mrjc(defaultBranch.hashCode, score.hashCode)))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is FavoritesRepoTableData &&
          other.id == this.id &&
          other.nodeId == this.nodeId &&
          other.name == this.name &&
          other.fullName == this.fullName &&
          other.ownerId == this.ownerId &&
          other.private == this.private &&
          other.htmlUrl == this.htmlUrl &&
          other.description == this.description &&
          other.fork == this.fork &&
          other.url == this.url &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.pushedAt == this.pushedAt &&
          other.homepage == this.homepage &&
          other.size == this.size &&
          other.stargazersCount == this.stargazersCount &&
          other.watchersCount == this.watchersCount &&
          other.language == this.language &&
          other.forksCount == this.forksCount &&
          other.openIssuesCount == this.openIssuesCount &&
          other.masterBranch == this.masterBranch &&
          other.defaultBranch == this.defaultBranch &&
          other.score == this.score);
}

class FavoritesRepoTableCompanion
    extends UpdateCompanion<FavoritesRepoTableData> {
  final Value<int> id;
  final Value<String> nodeId;
  final Value<String> name;
  final Value<String> fullName;
  final Value<int> ownerId;
  final Value<bool> private;
  final Value<String> htmlUrl;
  final Value<String> description;
  final Value<bool> fork;
  final Value<String> url;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> pushedAt;
  final Value<String> homepage;
  final Value<int> size;
  final Value<int> stargazersCount;
  final Value<int> watchersCount;
  final Value<String> language;
  final Value<int> forksCount;
  final Value<int> openIssuesCount;
  final Value<String> masterBranch;
  final Value<String> defaultBranch;
  final Value<double> score;
  const FavoritesRepoTableCompanion({
    this.id = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.name = const Value.absent(),
    this.fullName = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.private = const Value.absent(),
    this.htmlUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.fork = const Value.absent(),
    this.url = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pushedAt = const Value.absent(),
    this.homepage = const Value.absent(),
    this.size = const Value.absent(),
    this.stargazersCount = const Value.absent(),
    this.watchersCount = const Value.absent(),
    this.language = const Value.absent(),
    this.forksCount = const Value.absent(),
    this.openIssuesCount = const Value.absent(),
    this.masterBranch = const Value.absent(),
    this.defaultBranch = const Value.absent(),
    this.score = const Value.absent(),
  });
  FavoritesRepoTableCompanion.insert({
    this.id = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.name = const Value.absent(),
    this.fullName = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.private = const Value.absent(),
    this.htmlUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.fork = const Value.absent(),
    this.url = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pushedAt = const Value.absent(),
    this.homepage = const Value.absent(),
    this.size = const Value.absent(),
    this.stargazersCount = const Value.absent(),
    this.watchersCount = const Value.absent(),
    this.language = const Value.absent(),
    this.forksCount = const Value.absent(),
    this.openIssuesCount = const Value.absent(),
    this.masterBranch = const Value.absent(),
    this.defaultBranch = const Value.absent(),
    this.score = const Value.absent(),
  });
  static Insertable<FavoritesRepoTableData> custom({
    Expression<int> id,
    Expression<String> nodeId,
    Expression<String> name,
    Expression<String> fullName,
    Expression<int> ownerId,
    Expression<bool> private,
    Expression<String> htmlUrl,
    Expression<String> description,
    Expression<bool> fork,
    Expression<String> url,
    Expression<String> createdAt,
    Expression<String> updatedAt,
    Expression<String> pushedAt,
    Expression<String> homepage,
    Expression<int> size,
    Expression<int> stargazersCount,
    Expression<int> watchersCount,
    Expression<String> language,
    Expression<int> forksCount,
    Expression<int> openIssuesCount,
    Expression<String> masterBranch,
    Expression<String> defaultBranch,
    Expression<double> score,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nodeId != null) 'nodeId': nodeId,
      if (name != null) 'name': name,
      if (fullName != null) 'fullName': fullName,
      if (ownerId != null) 'ownerId': ownerId,
      if (private != null) 'private': private,
      if (htmlUrl != null) 'htmlUrl': htmlUrl,
      if (description != null) 'description': description,
      if (fork != null) 'fork': fork,
      if (url != null) 'url': url,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
      if (pushedAt != null) 'pushedAt': pushedAt,
      if (homepage != null) 'homepage': homepage,
      if (size != null) 'size': size,
      if (stargazersCount != null) 'stargazersCount': stargazersCount,
      if (watchersCount != null) 'watchersCount': watchersCount,
      if (language != null) 'language': language,
      if (forksCount != null) 'forksCount': forksCount,
      if (openIssuesCount != null) 'openIssuesCount': openIssuesCount,
      if (masterBranch != null) 'masterBranch': masterBranch,
      if (defaultBranch != null) 'defaultBranch': defaultBranch,
      if (score != null) 'score': score,
    });
  }

  FavoritesRepoTableCompanion copyWith(
      {Value<int> id,
      Value<String> nodeId,
      Value<String> name,
      Value<String> fullName,
      Value<int> ownerId,
      Value<bool> private,
      Value<String> htmlUrl,
      Value<String> description,
      Value<bool> fork,
      Value<String> url,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> pushedAt,
      Value<String> homepage,
      Value<int> size,
      Value<int> stargazersCount,
      Value<int> watchersCount,
      Value<String> language,
      Value<int> forksCount,
      Value<int> openIssuesCount,
      Value<String> masterBranch,
      Value<String> defaultBranch,
      Value<double> score}) {
    return FavoritesRepoTableCompanion(
      id: id ?? this.id,
      nodeId: nodeId ?? this.nodeId,
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      ownerId: ownerId ?? this.ownerId,
      private: private ?? this.private,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      description: description ?? this.description,
      fork: fork ?? this.fork,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pushedAt: pushedAt ?? this.pushedAt,
      homepage: homepage ?? this.homepage,
      size: size ?? this.size,
      stargazersCount: stargazersCount ?? this.stargazersCount,
      watchersCount: watchersCount ?? this.watchersCount,
      language: language ?? this.language,
      forksCount: forksCount ?? this.forksCount,
      openIssuesCount: openIssuesCount ?? this.openIssuesCount,
      masterBranch: masterBranch ?? this.masterBranch,
      defaultBranch: defaultBranch ?? this.defaultBranch,
      score: score ?? this.score,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nodeId.present) {
      map['nodeId'] = Variable<String>(nodeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (fullName.present) {
      map['fullName'] = Variable<String>(fullName.value);
    }
    if (ownerId.present) {
      map['ownerId'] = Variable<int>(ownerId.value);
    }
    if (private.present) {
      map['private'] = Variable<bool>(private.value);
    }
    if (htmlUrl.present) {
      map['htmlUrl'] = Variable<String>(htmlUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (fork.present) {
      map['fork'] = Variable<bool>(fork.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (createdAt.present) {
      map['createdAt'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updatedAt'] = Variable<String>(updatedAt.value);
    }
    if (pushedAt.present) {
      map['pushedAt'] = Variable<String>(pushedAt.value);
    }
    if (homepage.present) {
      map['homepage'] = Variable<String>(homepage.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (stargazersCount.present) {
      map['stargazersCount'] = Variable<int>(stargazersCount.value);
    }
    if (watchersCount.present) {
      map['watchersCount'] = Variable<int>(watchersCount.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (forksCount.present) {
      map['forksCount'] = Variable<int>(forksCount.value);
    }
    if (openIssuesCount.present) {
      map['openIssuesCount'] = Variable<int>(openIssuesCount.value);
    }
    if (masterBranch.present) {
      map['masterBranch'] = Variable<String>(masterBranch.value);
    }
    if (defaultBranch.present) {
      map['defaultBranch'] = Variable<String>(defaultBranch.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    return map;
  }
}

class $FavoritesRepoTableTable extends FavoritesRepoTable
    with TableInfo<$FavoritesRepoTableTable, FavoritesRepoTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $FavoritesRepoTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  GeneratedTextColumn _nodeId;
  @override
  GeneratedTextColumn get nodeId => _nodeId ??= _constructNodeId();
  GeneratedTextColumn _constructNodeId() {
    return GeneratedTextColumn(
      'nodeId',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fullNameMeta = const VerificationMeta('fullName');
  GeneratedTextColumn _fullName;
  @override
  GeneratedTextColumn get fullName => _fullName ??= _constructFullName();
  GeneratedTextColumn _constructFullName() {
    return GeneratedTextColumn(
      'fullName',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ownerIdMeta = const VerificationMeta('ownerId');
  GeneratedIntColumn _ownerId;
  @override
  GeneratedIntColumn get ownerId => _ownerId ??= _constructOwnerId();
  GeneratedIntColumn _constructOwnerId() {
    return GeneratedIntColumn('ownerId', $tableName, true,
        $customConstraints: 'NULLABLE REFERENCES ownertable(id)');
  }

  final VerificationMeta _privateMeta = const VerificationMeta('private');
  GeneratedBoolColumn _private;
  @override
  GeneratedBoolColumn get private => _private ??= _constructPrivate();
  GeneratedBoolColumn _constructPrivate() {
    return GeneratedBoolColumn(
      'private',
      $tableName,
      true,
    );
  }

  final VerificationMeta _htmlUrlMeta = const VerificationMeta('htmlUrl');
  GeneratedTextColumn _htmlUrl;
  @override
  GeneratedTextColumn get htmlUrl => _htmlUrl ??= _constructHtmlUrl();
  GeneratedTextColumn _constructHtmlUrl() {
    return GeneratedTextColumn(
      'htmlUrl',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _forkMeta = const VerificationMeta('fork');
  GeneratedBoolColumn _fork;
  @override
  GeneratedBoolColumn get fork => _fork ??= _constructFork();
  GeneratedBoolColumn _constructFork() {
    return GeneratedBoolColumn(
      'fork',
      $tableName,
      true,
    );
  }

  final VerificationMeta _urlMeta = const VerificationMeta('url');
  GeneratedTextColumn _url;
  @override
  GeneratedTextColumn get url => _url ??= _constructUrl();
  GeneratedTextColumn _constructUrl() {
    return GeneratedTextColumn(
      'url',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedTextColumn _createdAt;
  @override
  GeneratedTextColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedTextColumn _constructCreatedAt() {
    return GeneratedTextColumn(
      'createdAt',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedTextColumn _updatedAt;
  @override
  GeneratedTextColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedTextColumn _constructUpdatedAt() {
    return GeneratedTextColumn(
      'updatedAt',
      $tableName,
      true,
    );
  }

  final VerificationMeta _pushedAtMeta = const VerificationMeta('pushedAt');
  GeneratedTextColumn _pushedAt;
  @override
  GeneratedTextColumn get pushedAt => _pushedAt ??= _constructPushedAt();
  GeneratedTextColumn _constructPushedAt() {
    return GeneratedTextColumn(
      'pushedAt',
      $tableName,
      true,
    );
  }

  final VerificationMeta _homepageMeta = const VerificationMeta('homepage');
  GeneratedTextColumn _homepage;
  @override
  GeneratedTextColumn get homepage => _homepage ??= _constructHomepage();
  GeneratedTextColumn _constructHomepage() {
    return GeneratedTextColumn(
      'homepage',
      $tableName,
      true,
    );
  }

  final VerificationMeta _sizeMeta = const VerificationMeta('size');
  GeneratedIntColumn _size;
  @override
  GeneratedIntColumn get size => _size ??= _constructSize();
  GeneratedIntColumn _constructSize() {
    return GeneratedIntColumn(
      'size',
      $tableName,
      true,
    );
  }

  final VerificationMeta _stargazersCountMeta =
      const VerificationMeta('stargazersCount');
  GeneratedIntColumn _stargazersCount;
  @override
  GeneratedIntColumn get stargazersCount =>
      _stargazersCount ??= _constructStargazersCount();
  GeneratedIntColumn _constructStargazersCount() {
    return GeneratedIntColumn(
      'stargazersCount',
      $tableName,
      true,
    );
  }

  final VerificationMeta _watchersCountMeta =
      const VerificationMeta('watchersCount');
  GeneratedIntColumn _watchersCount;
  @override
  GeneratedIntColumn get watchersCount =>
      _watchersCount ??= _constructWatchersCount();
  GeneratedIntColumn _constructWatchersCount() {
    return GeneratedIntColumn(
      'watchersCount',
      $tableName,
      true,
    );
  }

  final VerificationMeta _languageMeta = const VerificationMeta('language');
  GeneratedTextColumn _language;
  @override
  GeneratedTextColumn get language => _language ??= _constructLanguage();
  GeneratedTextColumn _constructLanguage() {
    return GeneratedTextColumn(
      'language',
      $tableName,
      true,
    );
  }

  final VerificationMeta _forksCountMeta = const VerificationMeta('forksCount');
  GeneratedIntColumn _forksCount;
  @override
  GeneratedIntColumn get forksCount => _forksCount ??= _constructForksCount();
  GeneratedIntColumn _constructForksCount() {
    return GeneratedIntColumn(
      'forksCount',
      $tableName,
      true,
    );
  }

  final VerificationMeta _openIssuesCountMeta =
      const VerificationMeta('openIssuesCount');
  GeneratedIntColumn _openIssuesCount;
  @override
  GeneratedIntColumn get openIssuesCount =>
      _openIssuesCount ??= _constructOpenIssuesCount();
  GeneratedIntColumn _constructOpenIssuesCount() {
    return GeneratedIntColumn(
      'openIssuesCount',
      $tableName,
      true,
    );
  }

  final VerificationMeta _masterBranchMeta =
      const VerificationMeta('masterBranch');
  GeneratedTextColumn _masterBranch;
  @override
  GeneratedTextColumn get masterBranch =>
      _masterBranch ??= _constructMasterBranch();
  GeneratedTextColumn _constructMasterBranch() {
    return GeneratedTextColumn(
      'masterBranch',
      $tableName,
      true,
    );
  }

  final VerificationMeta _defaultBranchMeta =
      const VerificationMeta('defaultBranch');
  GeneratedTextColumn _defaultBranch;
  @override
  GeneratedTextColumn get defaultBranch =>
      _defaultBranch ??= _constructDefaultBranch();
  GeneratedTextColumn _constructDefaultBranch() {
    return GeneratedTextColumn(
      'defaultBranch',
      $tableName,
      true,
    );
  }

  final VerificationMeta _scoreMeta = const VerificationMeta('score');
  GeneratedRealColumn _score;
  @override
  GeneratedRealColumn get score => _score ??= _constructScore();
  GeneratedRealColumn _constructScore() {
    return GeneratedRealColumn(
      'score',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        nodeId,
        name,
        fullName,
        ownerId,
        private,
        htmlUrl,
        description,
        fork,
        url,
        createdAt,
        updatedAt,
        pushedAt,
        homepage,
        size,
        stargazersCount,
        watchersCount,
        language,
        forksCount,
        openIssuesCount,
        masterBranch,
        defaultBranch,
        score
      ];
  @override
  $FavoritesRepoTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'favorites_repo_table';
  @override
  final String actualTableName = 'favorites_repo_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<FavoritesRepoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('nodeId')) {
      context.handle(_nodeIdMeta,
          nodeId.isAcceptableOrUnknown(data['nodeId'], _nodeIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('fullName')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['fullName'], _fullNameMeta));
    }
    if (data.containsKey('ownerId')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['ownerId'], _ownerIdMeta));
    }
    if (data.containsKey('private')) {
      context.handle(_privateMeta,
          private.isAcceptableOrUnknown(data['private'], _privateMeta));
    }
    if (data.containsKey('htmlUrl')) {
      context.handle(_htmlUrlMeta,
          htmlUrl.isAcceptableOrUnknown(data['htmlUrl'], _htmlUrlMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('fork')) {
      context.handle(
          _forkMeta, fork.isAcceptableOrUnknown(data['fork'], _forkMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url'], _urlMeta));
    }
    if (data.containsKey('createdAt')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['createdAt'], _createdAtMeta));
    }
    if (data.containsKey('updatedAt')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updatedAt'], _updatedAtMeta));
    }
    if (data.containsKey('pushedAt')) {
      context.handle(_pushedAtMeta,
          pushedAt.isAcceptableOrUnknown(data['pushedAt'], _pushedAtMeta));
    }
    if (data.containsKey('homepage')) {
      context.handle(_homepageMeta,
          homepage.isAcceptableOrUnknown(data['homepage'], _homepageMeta));
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size'], _sizeMeta));
    }
    if (data.containsKey('stargazersCount')) {
      context.handle(
          _stargazersCountMeta,
          stargazersCount.isAcceptableOrUnknown(
              data['stargazersCount'], _stargazersCountMeta));
    }
    if (data.containsKey('watchersCount')) {
      context.handle(
          _watchersCountMeta,
          watchersCount.isAcceptableOrUnknown(
              data['watchersCount'], _watchersCountMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language'], _languageMeta));
    }
    if (data.containsKey('forksCount')) {
      context.handle(
          _forksCountMeta,
          forksCount.isAcceptableOrUnknown(
              data['forksCount'], _forksCountMeta));
    }
    if (data.containsKey('openIssuesCount')) {
      context.handle(
          _openIssuesCountMeta,
          openIssuesCount.isAcceptableOrUnknown(
              data['openIssuesCount'], _openIssuesCountMeta));
    }
    if (data.containsKey('masterBranch')) {
      context.handle(
          _masterBranchMeta,
          masterBranch.isAcceptableOrUnknown(
              data['masterBranch'], _masterBranchMeta));
    }
    if (data.containsKey('defaultBranch')) {
      context.handle(
          _defaultBranchMeta,
          defaultBranch.isAcceptableOrUnknown(
              data['defaultBranch'], _defaultBranchMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score'], _scoreMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoritesRepoTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return FavoritesRepoTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FavoritesRepoTableTable createAlias(String alias) {
    return $FavoritesRepoTableTable(_db, alias);
  }
}

class OwnerTableData extends DataClass implements Insertable<OwnerTableData> {
  final int id;
  final String login;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
  final String url;
  final String receivedEventsUrl;
  final String type;
  OwnerTableData(
      {@required this.id,
      this.login,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.receivedEventsUrl,
      this.type});
  factory OwnerTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return OwnerTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      login:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}login']),
      nodeId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nodeId']),
      avatarUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}avatarUrl']),
      gravatarId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}gravatarId']),
      url: stringType.mapFromDatabaseResponse(data['${effectivePrefix}url']),
      receivedEventsUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}receivedEventsUrl']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || login != null) {
      map['login'] = Variable<String>(login);
    }
    if (!nullToAbsent || nodeId != null) {
      map['nodeId'] = Variable<String>(nodeId);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatarUrl'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || gravatarId != null) {
      map['gravatarId'] = Variable<String>(gravatarId);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || receivedEventsUrl != null) {
      map['receivedEventsUrl'] = Variable<String>(receivedEventsUrl);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    return map;
  }

  OwnerTableCompanion toCompanion(bool nullToAbsent) {
    return OwnerTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      login:
          login == null && nullToAbsent ? const Value.absent() : Value(login),
      nodeId:
          nodeId == null && nullToAbsent ? const Value.absent() : Value(nodeId),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      gravatarId: gravatarId == null && nullToAbsent
          ? const Value.absent()
          : Value(gravatarId),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      receivedEventsUrl: receivedEventsUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedEventsUrl),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory OwnerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return OwnerTableData(
      id: serializer.fromJson<int>(json['id']),
      login: serializer.fromJson<String>(json['login']),
      nodeId: serializer.fromJson<String>(json['nodeId']),
      avatarUrl: serializer.fromJson<String>(json['avatarUrl']),
      gravatarId: serializer.fromJson<String>(json['gravatarId']),
      url: serializer.fromJson<String>(json['url']),
      receivedEventsUrl: serializer.fromJson<String>(json['receivedEventsUrl']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'login': serializer.toJson<String>(login),
      'nodeId': serializer.toJson<String>(nodeId),
      'avatarUrl': serializer.toJson<String>(avatarUrl),
      'gravatarId': serializer.toJson<String>(gravatarId),
      'url': serializer.toJson<String>(url),
      'receivedEventsUrl': serializer.toJson<String>(receivedEventsUrl),
      'type': serializer.toJson<String>(type),
    };
  }

  OwnerTableData copyWith(
          {int id,
          String login,
          String nodeId,
          String avatarUrl,
          String gravatarId,
          String url,
          String receivedEventsUrl,
          String type}) =>
      OwnerTableData(
        id: id ?? this.id,
        login: login ?? this.login,
        nodeId: nodeId ?? this.nodeId,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        gravatarId: gravatarId ?? this.gravatarId,
        url: url ?? this.url,
        receivedEventsUrl: receivedEventsUrl ?? this.receivedEventsUrl,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('OwnerTableData(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('nodeId: $nodeId, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('gravatarId: $gravatarId, ')
          ..write('url: $url, ')
          ..write('receivedEventsUrl: $receivedEventsUrl, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          login.hashCode,
          $mrjc(
              nodeId.hashCode,
              $mrjc(
                  avatarUrl.hashCode,
                  $mrjc(
                      gravatarId.hashCode,
                      $mrjc(
                          url.hashCode,
                          $mrjc(
                              receivedEventsUrl.hashCode, type.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is OwnerTableData &&
          other.id == this.id &&
          other.login == this.login &&
          other.nodeId == this.nodeId &&
          other.avatarUrl == this.avatarUrl &&
          other.gravatarId == this.gravatarId &&
          other.url == this.url &&
          other.receivedEventsUrl == this.receivedEventsUrl &&
          other.type == this.type);
}

class OwnerTableCompanion extends UpdateCompanion<OwnerTableData> {
  final Value<int> id;
  final Value<String> login;
  final Value<String> nodeId;
  final Value<String> avatarUrl;
  final Value<String> gravatarId;
  final Value<String> url;
  final Value<String> receivedEventsUrl;
  final Value<String> type;
  const OwnerTableCompanion({
    this.id = const Value.absent(),
    this.login = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.gravatarId = const Value.absent(),
    this.url = const Value.absent(),
    this.receivedEventsUrl = const Value.absent(),
    this.type = const Value.absent(),
  });
  OwnerTableCompanion.insert({
    this.id = const Value.absent(),
    this.login = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.gravatarId = const Value.absent(),
    this.url = const Value.absent(),
    this.receivedEventsUrl = const Value.absent(),
    this.type = const Value.absent(),
  });
  static Insertable<OwnerTableData> custom({
    Expression<int> id,
    Expression<String> login,
    Expression<String> nodeId,
    Expression<String> avatarUrl,
    Expression<String> gravatarId,
    Expression<String> url,
    Expression<String> receivedEventsUrl,
    Expression<String> type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (login != null) 'login': login,
      if (nodeId != null) 'nodeId': nodeId,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (gravatarId != null) 'gravatarId': gravatarId,
      if (url != null) 'url': url,
      if (receivedEventsUrl != null) 'receivedEventsUrl': receivedEventsUrl,
      if (type != null) 'type': type,
    });
  }

  OwnerTableCompanion copyWith(
      {Value<int> id,
      Value<String> login,
      Value<String> nodeId,
      Value<String> avatarUrl,
      Value<String> gravatarId,
      Value<String> url,
      Value<String> receivedEventsUrl,
      Value<String> type}) {
    return OwnerTableCompanion(
      id: id ?? this.id,
      login: login ?? this.login,
      nodeId: nodeId ?? this.nodeId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gravatarId: gravatarId ?? this.gravatarId,
      url: url ?? this.url,
      receivedEventsUrl: receivedEventsUrl ?? this.receivedEventsUrl,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (login.present) {
      map['login'] = Variable<String>(login.value);
    }
    if (nodeId.present) {
      map['nodeId'] = Variable<String>(nodeId.value);
    }
    if (avatarUrl.present) {
      map['avatarUrl'] = Variable<String>(avatarUrl.value);
    }
    if (gravatarId.present) {
      map['gravatarId'] = Variable<String>(gravatarId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (receivedEventsUrl.present) {
      map['receivedEventsUrl'] = Variable<String>(receivedEventsUrl.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }
}

class $OwnerTableTable extends OwnerTable
    with TableInfo<$OwnerTableTable, OwnerTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $OwnerTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _loginMeta = const VerificationMeta('login');
  GeneratedTextColumn _login;
  @override
  GeneratedTextColumn get login => _login ??= _constructLogin();
  GeneratedTextColumn _constructLogin() {
    return GeneratedTextColumn(
      'login',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  GeneratedTextColumn _nodeId;
  @override
  GeneratedTextColumn get nodeId => _nodeId ??= _constructNodeId();
  GeneratedTextColumn _constructNodeId() {
    return GeneratedTextColumn(
      'nodeId',
      $tableName,
      true,
    );
  }

  final VerificationMeta _avatarUrlMeta = const VerificationMeta('avatarUrl');
  GeneratedTextColumn _avatarUrl;
  @override
  GeneratedTextColumn get avatarUrl => _avatarUrl ??= _constructAvatarUrl();
  GeneratedTextColumn _constructAvatarUrl() {
    return GeneratedTextColumn(
      'avatarUrl',
      $tableName,
      true,
    );
  }

  final VerificationMeta _gravatarIdMeta = const VerificationMeta('gravatarId');
  GeneratedTextColumn _gravatarId;
  @override
  GeneratedTextColumn get gravatarId => _gravatarId ??= _constructGravatarId();
  GeneratedTextColumn _constructGravatarId() {
    return GeneratedTextColumn(
      'gravatarId',
      $tableName,
      true,
    );
  }

  final VerificationMeta _urlMeta = const VerificationMeta('url');
  GeneratedTextColumn _url;
  @override
  GeneratedTextColumn get url => _url ??= _constructUrl();
  GeneratedTextColumn _constructUrl() {
    return GeneratedTextColumn(
      'url',
      $tableName,
      true,
    );
  }

  final VerificationMeta _receivedEventsUrlMeta =
      const VerificationMeta('receivedEventsUrl');
  GeneratedTextColumn _receivedEventsUrl;
  @override
  GeneratedTextColumn get receivedEventsUrl =>
      _receivedEventsUrl ??= _constructReceivedEventsUrl();
  GeneratedTextColumn _constructReceivedEventsUrl() {
    return GeneratedTextColumn(
      'receivedEventsUrl',
      $tableName,
      true,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, login, nodeId, avatarUrl, gravatarId, url, receivedEventsUrl, type];
  @override
  $OwnerTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'owner_table';
  @override
  final String actualTableName = 'owner_table';
  @override
  VerificationContext validateIntegrity(Insertable<OwnerTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('login')) {
      context.handle(
          _loginMeta, login.isAcceptableOrUnknown(data['login'], _loginMeta));
    }
    if (data.containsKey('nodeId')) {
      context.handle(_nodeIdMeta,
          nodeId.isAcceptableOrUnknown(data['nodeId'], _nodeIdMeta));
    }
    if (data.containsKey('avatarUrl')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatarUrl'], _avatarUrlMeta));
    }
    if (data.containsKey('gravatarId')) {
      context.handle(
          _gravatarIdMeta,
          gravatarId.isAcceptableOrUnknown(
              data['gravatarId'], _gravatarIdMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url'], _urlMeta));
    }
    if (data.containsKey('receivedEventsUrl')) {
      context.handle(
          _receivedEventsUrlMeta,
          receivedEventsUrl.isAcceptableOrUnknown(
              data['receivedEventsUrl'], _receivedEventsUrlMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OwnerTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return OwnerTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $OwnerTableTable createAlias(String alias) {
    return $OwnerTableTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $FavoritesRepoTableTable _favoritesRepoTable;
  $FavoritesRepoTableTable get favoritesRepoTable =>
      _favoritesRepoTable ??= $FavoritesRepoTableTable(this);
  $OwnerTableTable _ownerTable;
  $OwnerTableTable get ownerTable => _ownerTable ??= $OwnerTableTable(this);
  RepoDao _repoDao;
  RepoDao get repoDao => _repoDao ??= RepoDao(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [favoritesRepoTable, ownerTable];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$RepoDaoMixin on DatabaseAccessor<Database> {
  $FavoritesRepoTableTable get favoritesRepoTable =>
      attachedDatabase.favoritesRepoTable;
  $OwnerTableTable get ownerTable => attachedDatabase.ownerTable;
}
