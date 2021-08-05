import 'package:weather/domain/city_model.dart';

/// Хранит текущий город
class AppStorageRepository {
  AppStorageRepository();

  //TODO: релизовать взаимодействие с Hive

  /// Инициализация текущего города. Если в хранилище ничего нет - там останется Moscow
  CityModel _currentCity = CityModel(city: "Moscow");

  set city(String city) {
    _currentCity = CityModel(city: city);
    print(_currentCity.city);
  }

  String get getCity => _currentCity.city;
}
