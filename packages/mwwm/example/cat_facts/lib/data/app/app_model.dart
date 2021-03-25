import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

class AppModel extends Model {
  AppModel({
    List<Performer<Object, Change>> performers = const [],
  }) : super(performers);

  final appTheme = StreamedState<AppTheme>(AppTheme.light);

  void changeTheme() {
    final current = appTheme.value;
    appTheme
        .accept((current == AppTheme.dark) ? AppTheme.light : AppTheme.dark);
  }
}
