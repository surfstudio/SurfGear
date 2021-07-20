# Cat facts

## Goldens

To regenerate goldens to capture your new reference images use command:

```bash
flutter test --update-goldens
```

## Localization

First of you need to global activate intl_generator, use command:

```bash
flutter pub global activate intl_generator
```

To generate arb files use command:

```bash
flutter pub global run intl_generator:extract_to_arb --output-dir=lib/l10n lib/localizations.dart
```

To generate dart files from arb use command:

```bash
flutter pub global run intl_generator:generate_from_arb lib/localizations.dart lib/l10n/*.arb --output-dir=lib/l10n
```
