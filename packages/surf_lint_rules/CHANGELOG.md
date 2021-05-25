# Changelog

## PATCH

* Tune metrics settings

## 1.1.1-dev.2 - 2021-05-24

* Set min SDK version to `2.13.0`. (patch)
* Tune `avoid-returning-widgets`. (patch)

## 1.1.1-dev.1 - 2021-05-24

* Add some rules: `avoid_multiple_declarations_per_line`, `deprecated_consistency`, `prefer_if_elements_to_conditional_expressions`, `unnecessary_null_checks`, `unnecessary_nullable_for_final_variable_declarations`, `use_if_null_to_convert_nulls_to_bools`, `use_late_for_private_fields_and_variables`, `use_named_constants`, `missing_whitespace_between_adjacent_strings`, `avoid_type_to_string`, `use_build_context_synchronously`. (minor)
* Disable rules: `sort_child_properties_last`, `sort_constructors_first`, `sort_unnamed_constructors_first`. (minor)

## 1.1.0

* Bump pedantic version.
* Add [dart-code-metrics](https://pub.dev/packages/dart_code_metrics) dependency.

## 1.0.0

* Migrated to null safety, min SDK is `2.12.0`.

## 0.0.2-dev.6

* Add new error-rule : no_runtimeType_toString.
* Lint level changed from warning to error for : type_annotate_public_apis, await_only_futures, always_declare_return_types rules.
* Add new rule : flutter_style_todos

## 0.0.2-dev.2

* Disabled lines_longer_than_80_chars to increase line length without warnings

## 0.0.1-dev.0

* Initial release
