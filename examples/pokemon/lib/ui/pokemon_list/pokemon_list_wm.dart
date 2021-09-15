import 'package:mwwm/mwwm.dart';
import 'package:surf_logger/surf_logger.dart';

class PokemonListWM extends WidgetModel {
  PokemonListWM(WidgetModelDependencies baseDependencies) : super(baseDependencies);

  @override
  void onLoad() {
    super.onLoad();
    Logger.d("PokemonListWidgetModel has been loaded");
  }  
}