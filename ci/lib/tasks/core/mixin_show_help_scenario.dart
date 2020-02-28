mixin MixinShowHelpScenario {
  /// Имя команды
  String get getCommandName;

  /// Описание команды
  String get helpInfo;

  /// Показать help по командам
  Future<void> showHelpCommand() async {
    var stringBuffer = StringBuffer();
    stringBuffer.write('$getCommandName:');
    stringBuffer.write('\t\t');
    stringBuffer.write(helpInfo);
    print(stringBuffer);
    await showHelpOption();
  }

  /// Переопределить, если есть оптиции или флаги
  Future<void> showHelpOption() async {}
}
