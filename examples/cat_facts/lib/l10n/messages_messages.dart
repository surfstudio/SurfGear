// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  String get localeName => 'messages';

  static m0(number) => "Fact #${number}";

  static m1(number, numberText) => "${Intl.plural(number, one: 'Loaded one fact', other: 'Loaded ${numberText} facts')}";

  static m2(count) => "Total loaded symbols ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "FactListTileI18n_title" : m0,
    "FactsScreenI18n_fetchFact" : MessageLookupByLibrary.simpleMessage("More"),
    "FactsScreenI18n_fetchedFacts" : m1,
    "FactsScreenI18n_title" : MessageLookupByLibrary.simpleMessage("Cats facts"),
    "FactsScreenI18n_totalLoaded" : m2,
    "ThemeButtonI18n_switchOff" : MessageLookupByLibrary.simpleMessage("Switch Off"),
    "ThemeButtonI18n_switchOn" : MessageLookupByLibrary.simpleMessage("Switch On")
  };
}
