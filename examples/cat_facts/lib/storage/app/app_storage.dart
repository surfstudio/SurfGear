import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/interactor/api_client.dart';
import 'package:relation/relation.dart';

class AppStorage {
  final appTheme = StreamedState<AppTheme>(AppTheme.light);

  final ApiClient apiClient = ApiClient();

  void changeTheme() {
    final current = appTheme.value;
    appTheme
        .accept((current == AppTheme.dark) ? AppTheme.light : AppTheme.dark);
  }
}
