import 'package:flutter/material.dart';
import 'package:my_anime/data/api/jikan_api.dart';
import 'package:my_anime/repositories/anime_repository.dart';
import 'package:my_anime/ui/app/app.dart';
import 'package:my_anime/ui/app/app_component.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:dio/dio.dart';

void main() {
  final Dio dio = Dio();
  final RestClient client = RestClient(dio);
  final AnimeRepository repository = AnimeRepository(client);
  runApp(
    Injector(
      component: AppComponent(repository),
      builder: (_) => App(),
    ),
  );
}
