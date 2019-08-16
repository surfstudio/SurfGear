import 'package:name_generator/domain/User.dart';
import 'package:name_generator/interactor/name_generator/repository/data/name_generator_response.dart';
import 'package:network/network.dart';
import 'package:rxdart/rxdart.dart';

const String _url = 'https://uinames.com/api/?ext';

/// Repository для namefake.com/api
class NameGeneratorRepository {
  RxHttp _http;

  NameGeneratorRepository(this._http);

  /// Получение параметров пользователя
  Observable<User> getUser() => _http.get(_url).map((r) {
        return NameGeneratorResponse.fromJson(r.body).transform();
      });
}
