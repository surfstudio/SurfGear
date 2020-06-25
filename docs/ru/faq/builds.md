[Главная](../main.md)

# FAQ по сборке

Решаем проблемы с типами сборки.

Если вы пришли сюда за ответами на вопросы, но ещё не читали [рукводство по орагнизации Flavors во Flutter](../best_practice/flavors/flavors_long.md) - сначала обязательно прочитайте его.

## Падает локальная сборка iOS через Fastlane

 - **No profile for team 'XXXXXXXXX' matching. Install the profile (by dragging and dropping it onto Xcode's dock item) or select a different one in the General tab of the target editor.**
   <br><br>
   Проблема решилась предоставлением расширенных прав на директорию:
   <br>
   `sudo chmod 755 /Users/{username}/Library/Logs/gym/`
   <br><br>
 - **Permission denied @ rb_sysopen - /Users/{username}/{project-dir}/ios/{cer-name}.cer**
   <br><br>
   Проблема решилась предоставлением расширенных прав на директорию:
   <br>
   `sudo chmod 755 /Users/{username}/{project-dir}/ios/*`

## После удаления пакета из pubspec.yaml падает сборка под iOS

 - **ld: framework not found {packageName}.**
   <br><br>
   Проблема вызвана тем, что по какой-то причине после удаления пакета
из проекта не очищаются linker flags. Это необходимо сделать вручную в
Xcode.
   <br>
1. В `Project navigator` кликните на `Runner`;
2. Перейдите на вкладку `Build Settings`;
3. В поиск введите название проблемного пакета: результат поиска должен
находиться в разделе `Other Linker Flags`. Раскройте список флагов и
вручную удалите оттуда лишний.
4. Далее, пушим изменения в гит. Сборка должна починиться.

## Не получается собрать profile-сборку под iOS

 - **Отсутствует нужная Build Configuration в XCode.**
    <br><br>
    Внимательно читайте ошибку, которая возникает в консоли при сборке.
    В ней будет указано имя Build Configuration, которое не удалось найти.
    Нужно будет создать такую Build Configuration в вашем проекте через
    XCode.
    <br><br>
    ![build_settings](../../img/faq/profile_build_config.png)
    <br><br>
 - **Profile-сборка падает при попытке собрать её под iOS, хотя dev-сборка собирается успешно.**
    <br><br>
    Если в теле ошибки появляются логи, чаще всего про то, что какие-то
    классы не удалось зарезолвить, одна из вероятных причин -
    отсутствие значения в настройки Objective-C Bridging Header для
    использумой вами Build Configuration. Чтобы пофиксить это - просто
    используйте тоже значение, которое указано у других конфигураций.
    <br><br>
    ![build_settings](../../img/faq/obj_c_build_header.png)
    <br><br>