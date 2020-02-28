mixin MixinShowHelpScenario {
  /// Имя команды
  String get getCommandName;

  /// Описание команды
  String get helpInfo;

  /// Показать help по командам
  ///
  /// [maxLengthNameCommand]  длина имени самой длинной команды.
  /// '8' эквивалетно двум табам
  Future<void> showHelpCommand([int maxLengthNameCommand]) async {
    var stringBuffer = StringBuffer();
    stringBuffer.write('$getCommandName:');
    stringBuffer.write(_indent(maxLengthNameCommand));

    stringBuffer.write(helpInfo);
    print(stringBuffer);
    await showHelpOption();
  }

  ///  Возвращает отступ в консоли между название команды и её help
  ///  нужен для выравнивания
  String _indent(int maxLengthNameCommand) {
    var lengthNameCommand = (maxLengthNameCommand - getCommandName.length).abs();
    return ' ' * lengthNameCommand + '\t\t';
  }

  /// Переопределить и описать, если есть оптиции или флаги
  Future<void> showHelpOption() async {}
}
