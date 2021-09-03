import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_anime/data/storage/hive/anime_hive_object.dart';

Future<void> hiveSetup() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AnimeHiveObjectAdapter());
  await Hive.openBox<AnimeHiveObject>('favorites');
}
