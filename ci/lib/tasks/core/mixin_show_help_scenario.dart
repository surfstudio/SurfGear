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
    if (maxLengthNameCommand == null || maxLengthNameCommand < 8) {
      stringBuffer.write('\t\t');
    } else {
      stringBuffer.write(_indent(maxLengthNameCommand));
    }
    stringBuffer.write(helpInfo);
    print(stringBuffer);
    await showHelpOption();
  }

  String _indent(int maxLengthNameCommand) {
    var amountTab = (maxLengthNameCommand - getCommandName.length);
    return ' ' * amountTab + '\t\t';
  }

  /// Переопределить и описать, если есть оптиции или флаги
  Future<void> showHelpOption() async {}
}
