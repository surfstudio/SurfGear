import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/config/env/env.dart';

///URL запросов сервера
abstract class Url {
  static String get testUrl => "http://uinames.com/api/";

  static String get prodUrl => "https://prod.surfstudio.ru/api";

  static String get devUrl => "https://localhost:9999/food/hs/ExchangeSotr";

  static String get baseUrl => Environment<Config>.instance().config.url;
}
