#### [SurfGear](https://github.com/surfstudio/SurfGear)

Данный набор snippets помогает избежать рутинных действий при создании нового screen.

Установка:

Для Android Studio и продуктов JetBrains
File -> Import Settings -> находим файл snippets.zip

Для VSCode
перенести файлы из папки vscode и разместить по пути 
Library/Application Support/Code/User/snippets
(создать папку snippets, если не существует)
/// для к папке Library необходимо открыть скрытые файлы

snippets:
scr - создаёт макет для класса MwwmWidget
cmw - создаёт макет для класса WidgetModel
cmp - создаёт макет для класса Component
cpr - создаёт макет для класса Performer
chain - создаёт макет для класса Chains

Использование:
В файле пишем слово триггер и всплывёт подсказка для использования snippet.
Каретка автоматически ставится на имя класса, которое нужно ввести, 
клавишей tab происходит переключение на следующее имя для ввода
