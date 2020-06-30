import 'package:args/args.dart';
import 'package:meta/meta.dart';

/// Миксин для генерации помощи по использованию сценария, где key - это имя команды, подкоманды или опции, а
/// value - текст help соответствующему key
mixin ScenarioHelpMixin {
  /// Имя команды
  @protected
  String get getCommandName;

  /// key для мапы с опциями
  static final _keyMapOption = 'keyOptions';

  /// Возвращает хелп опций и подкоманд команды
  /// Вид мапы принимает варианты Map<String, String> или Map<String, Map>
  @protected
  Map<String, dynamic> getHelp(ArgParser argParser, [String nameSubCommand]) {
    var command = nameSubCommand ?? getCommandName;
    return <String, dynamic>{
      command: getCommandsHelp()[command],
      _keyMapOption: _getOptionHelp(argParser),
    };
  }

  /// Возвращаем мапу, где key - это [option + abbr] / [nameSubCommand], если имеются подкоманды,
  /// то рекурсивно находим её опции и флаги
  Map<String, dynamic> _getOptionHelp(ArgParser argParser) {
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
        mapHelp.addAll(getHelp(argParser.commands[_key], _key));
      }
    }

    return mapHelp;
  }

  /// Переопределить, если нужно добавить информацию в help для подкоманды, где
  /// Map<String = nameSubCommand , String = help>
  @protected
  Map<String, String> getCommandsHelp();
}
