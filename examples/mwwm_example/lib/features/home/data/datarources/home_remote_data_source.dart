import 'package:dio/dio.dart';
import 'package:mwwm_example/features/home/data/models/home_data_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeDataModel> getHomeData(String accessToken);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<HomeDataModel> getHomeData(String accessToken) async {
    final result = await Dio()
        .get<dynamic>('https://mockend.com/VVPAK/mwwm_example/posts');
    return HomeDataModel.fromJson(result.data as List<dynamic>);
  }
}
