import 'package:intl/intl.dart';

class FactListTileI18n {
  static String title(String number) {
    return Intl.message(
      'Fact #$number',
      desc: 'Fact list title',
      name: 'FactListTileI18n_title',
      args: [number],
    );
  }
}

class ThemeButtonI18n {
  static String get switchOff => Intl.message(
        'Switch Off',
        desc: 'Switch to dark theme title',
        name: 'ThemeButtonI18n_switchOff',
      );

  static String get switchOn => Intl.message(
        'Switch On',
        desc: 'Switch to light theme title',
        name: 'ThemeButtonI18n_switchOn',
      );
}

class FactsScreenI18n {
  static String get title => Intl.message(
        'Cats facts',
        desc: 'Application title',
        name: 'FactsScreenI18n_title',
      );

  static String get fetchFact => Intl.message(
        'More',
        desc: 'Fetch new fact',
        name: 'FactsScreenI18n_fetchFact',
      );

  static String fetchedFacts(int number, String numberText) {
    return Intl.plural(
      number,
      one: 'Loaded one fact',
//      two: 'Loaded $numberText facts',
//      few: 'Loaded $numberText facts',
//      many: 'Loaded $numberText facts',
      other: 'Loaded $numberText facts',
      desc: 'Fetched facts label',
      name: 'FactsScreenI18n_fetchedFacts',
      args: [number, numberText],
    );
  }

  static String totalLoaded(String count) {
    return Intl.message(
      'Total loaded symbols $count',
      desc: 'Fetched symbols label',
      name: 'FactsScreenI18n_totalLoaded',
      args: [count],
    );
  }
}
