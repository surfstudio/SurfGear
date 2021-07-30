import 'package:mwwm_example/features/home/data/datarources/home_remote_data_source.dart';
import 'package:mwwm_example/features/home/domain/entities/home_data.dart';
import 'package:mwwm_example/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;

  const HomeRepositoryImpl({required HomeRemoteDataSource homeRemoteDataSource})
      : _homeRemoteDataSource = homeRemoteDataSource;

  @override
  Future<HomeData> getHomePage(String accessToken) {
    return _homeRemoteDataSource.getHomeData(accessToken);
  }
}
