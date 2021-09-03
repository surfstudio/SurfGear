import 'package:hive_flutter/hive_flutter.dart';

part 'anime_hive_object.g.dart';

@HiveType(typeId: 0)
class AnimeHiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String endDate;

  @HiveField(2)
  final int episodes;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final int members;

  @HiveField(5)
  final int rank;

  @HiveField(6)
  final double score;

  @HiveField(7)
  final String startDate;

  @HiveField(8)
  final String title;

  @HiveField(9)
  final String type;

  AnimeHiveObject(
    this.id,
    this.endDate,
    this.episodes,
    this.imageUrl,
    this.members,
    this.rank,
    this.score,
    this.startDate,
    this.title,
    this.type,
  );
}
