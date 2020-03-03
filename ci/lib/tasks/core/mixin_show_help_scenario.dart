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
  Map<String, dynamic> getHelp(ArgParser argParser) {
    return <String, dynamic>{
      getCommandName: helpInfo,
      'option': _showHelpOption(argParser),
      'data': addSubCommandInHelp(),
    };
  }

  /// Генерим мапу, где key - [option + abbr]
  /// Делаем рекурсивно, на случай подкоманд
  Map<String, dynamic> _showHelpOption(ArgParser argParser) {
    var mapHelp = <String, dynamic>{};
    var keys = argParser.options.keys;
    for (var key in keys) {
      var val = '--' + argParser.options[key].name;
      if (argParser.options[key].abbr != null) {
        val += ', -' + argParser.options[key].abbr;
      }
      mapHelp.addAll({val: argParser.options[key].help});
    }
    if (argParser.commands != null && argParser.commands.isNotEmpty) {
      var _keys = argParser.commands.keys;
      for (var _key in _keys) {
        mapHelp.addAll(_showHelpOption(argParser.commands[_key]));
      }
    }
    return mapHelp;
  }

  /// Переопределить, если нужно добавить ещё информацию в help
  Map<String, dynamic> addSubCommandInHelp() {
    return {};
  }
}
