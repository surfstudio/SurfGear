# Continious Delivery

Для доставки артефактов тестировщикам используется fastlane(отвечает за выгрузку) 
и Beta by Fabric(сервис для распространения сборок).

О этапах сборки и выгрузки написано [здесь][build.md].

Данный документ описывает настройку Fabric.

Основная конфигурация для выгрузки в Beta настроена в шаблонном проекта.
В конкретном проекте необходимо проделать следующие шаги:

1. Создать [организацию в Fabric](https://www.fabric.io/settings/organizations)
1. Android:
    1. ./android/app/fabric.properties - добавить актуальные API_KEY/API_SECRET
    1. ./android/fastlane/Fastfile - добавить актуальные API_KEY/API_SECRET
    1. ./android/fastlane/Appfile - добавить актуальный package-name
1. iOS:
    1. ./ios/Runner/Info.plist - добавить актуальные API_KEY/API_SECRET в необходимые ключи
    1. ./ios/fastlane/Appfile - добавить учетные данные
    1. ./ios/fastlane/Fastfile - добавить актуальные API_KEY/API_SECRET и app_identifier
1. Стимулировать фатальную ошибку на одном из начальных экранов приложения.
1. Запустить приложение на девайсах обеих платформ. 

После этих шагов в Fabric должны появится два проекта соответствующие приложениям.