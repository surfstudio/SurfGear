import 'package:mwwm_example/core/usecase/usecase.dart';
import 'package:mwwm_example/features/auth/domain/repositories/auth_repository.dart';
import 'package:mwwm_example/features/home/domain/entities/home_data.dart';
import 'package:mwwm_example/features/home/domain/repositories/home_repository.dart';

class GetHomeData implements UseCase<HomeData, NoParams> {
  final AuthRepository authRepository;
  final HomeRepository homeRepository;

  GetHomeData({
    required this.authRepository,
    required this.homeRepository,
  });

  @override
  Future<HomeData> call(NoParams params) {
    return homeRepository.getHomePage(authRepository.accessToken);
  }
}
