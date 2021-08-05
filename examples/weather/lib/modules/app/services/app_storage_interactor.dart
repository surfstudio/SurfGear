import 'package:weather/modules/app/services/app_storage_repository.dart';

class AppStorageInteractor {
  final AppStorageRepository _appStorageRepository;

  AppStorageInteractor(
    this._appStorageRepository,
  );

  set city(String city) => _appStorageRepository.city = city;

  String get getCity => _appStorageRepository.getCity;
}
