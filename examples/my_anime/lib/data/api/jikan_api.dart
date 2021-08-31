import 'package:my_anime/data/raw_models/raw_anime_top.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../raw_models/raw_anime.dart';

part 'jikan_api.g.dart';

@RestApi(baseUrl: "https://api.jikan.moe/v3/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/anime/{id}")
  Future<RawAnime> getAnimeDetails(@Path("id") String id);

  @GET("/top/anime/{page}")
  Future<RawAnimeTop> getAnimeTop(@Path("page") String page);
}
