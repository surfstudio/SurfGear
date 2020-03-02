import 'package:args/args.dart';
import 'package:meta/meta.dart';

mixin MixinShowHelpScenario {
  /// Имя команды
  @protected
  String get getCommandName;

  /// Описание команды
  @protected
  String get helpInfo;

  /// Переопределить и описать, если есть опции или флаги
  @protected
  Map<String, String> getHelpMap(ArgParser argParser) {
    return <String, String>{
      getCommandName: helpInfo,
      ..._showHelpOption(argParser),
      ...addHelpData(),
    };
  }

  /// Генерим мапу, где key - [option + abbr]
  Map<String, String> _showHelpOption(ArgParser argParser) {
    var mapHelp = <String, String>{};
    var keys = argParser.options.keys;
    for (var key in keys) {
      var val = '--' + argParser.options[key].name;
      if (argParser.options[key].abbr != null) {
        val += ', -' + argParser.options[key].abbr;
      }
      mapHelp.addAll({val: argParser.options[key].help});
    }
    return mapHelp;
  }

  /// Переопределить, если нужно добавить ещё информацию в help
  Map<String, String> addHelpData() {
    return {};
  }
}
