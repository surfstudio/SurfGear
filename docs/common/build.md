# Сборка/выгрузка проекта

## Сборка

Для сборки артефактов предусмотрены скрипты из директории /script
Их выполнение происходит на Jenkins при Pr и Tag джобах.
Также возможно ручное выполнение скриптов из консоли.

- ./script/android/build-android-x64.sh - сборка qa/release (x64)
- ./script/android/build-android.sh - сборка qa/release
- ./script/ios/build-ios-pr.sh - ios сборка для PR Job ( подписанный Runner.app в двух версиях qa/release)
- ./script/ios/build-ios-qa.sh - неподписанная qa
- ./script/ios/build-ios-release.sh - неподписанная release

**ВАЖНО**: Все команды выполняютсмя из корня **проекта**(там где находится pubspec.yaml приложения)

## Выгрузка артефактов 

Для распространения артефактов мы используем **Beta by Fabric**.
Чтобы выгрузить сборки в данный сервис используется fastlane.

Основыне команды:

```
cd android/; fastlane android beta //android сборка

cd ios/; fastlane ios beta //ios сборка
```

**ВАЖНО**: При локальной выгрузке перед нейследует выполнить сборку проекта одним из описанных 
выше билдскриптов. 
