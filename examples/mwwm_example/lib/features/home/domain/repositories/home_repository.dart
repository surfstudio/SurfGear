import 'package:mwwm_example/features/home/domain/entities/home_data.dart';

abstract class HomeRepository {
  Future<HomeData> getHomePage(String accessToken);
}
