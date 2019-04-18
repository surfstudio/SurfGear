# Структура проекта | Project Structure

- ./ - папка проекта
- ./res
    - /assets/ - директория расположения графических ресурсов
- ./docs/ - документация проекта(тех.док, тех.долг)
- ./android/ - папка, содержащая нативный код для Android
- ./ios - аналогично для iOS
- ./lib/ - код на Dart, Flutter-приложение
    - ./lib
    - ./lib/domain - Domain -слой
    - ./lib/interactor - Interactor-слой
        - ./lib/interactor/common - общееиспользуемые классы
        - ./lib/interactor/*some_interactor*/repository - репозиторий для интерактора
    - ./lib/ui - UI-слой
        - ./lib/ui/app - пакет с главным виджетом приложения
        - ./lib/ui/base - базовые классы для ui
        - ./lib/ui/common - общеиспользуемые классы UI
        - ./lib/ui/res - пакет для ресурсов(strings.dart, colors.dart, text_styles.dart)
        - ./lib/ui/screen - пакеты конкретных экранов/виджетов(сам виджет + WM)
            ./lib/ui/screen/$someScreen/di - DI для экрана
    - ./lib/util - утилиты
- ./test - тесты
