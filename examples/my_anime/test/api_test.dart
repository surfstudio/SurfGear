import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:my_anime/data/api/jikan_api.dart';

void main() {
  test('test getting anime', () async {
    final dio = Dio(); // Provide a dio instance
    dio.options.headers["Demo-Header"] = "demo header"; // config your dio headers globally
    final client = RestClient(dio);

    await client.getAnimeDetails('1').then((anime) {
      print(anime.synopsis);
    });
    await client.getAnimeTop().then((top) {
      print(top);
    });
  });
}
