// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, always_declare_return_types

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static m0(number) => "Факт №${number}";

  static m1(number, numberText) => "${Intl.plural(number, one: 'Загружен один факт', two: 'Загружен два факта', few: 'Загружено ${numberText} факта', other: 'Загружено ${numberText} фактов')}";

  static m2(count) => "Всего загруженно символов: ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "FactListTileI18n_title" : m0,
    "FactsScreenI18n_fetchFact" : MessageLookupByLibrary.simpleMessage("Ещё"),
    "FactsScreenI18n_fetchedFacts" : m1,
    "FactsScreenI18n_title" : MessageLookupByLibrary.simpleMessage("О котах"),
    "FactsScreenI18n_totalLoaded" : m2,
    "ThemeButtonI18n_switchOff" : MessageLookupByLibrary.simpleMessage("Тёмная тема"),
    "ThemeButtonI18n_switchOn" : MessageLookupByLibrary.simpleMessage("Светлая тема")
  };
}
