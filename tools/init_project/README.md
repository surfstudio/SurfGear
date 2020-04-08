# init project

Creating a project template

## Описание

Утилита создаёт проект на основе шаблона

### FAQ
Обязательные опции:
-n, --name -    Имя шаблоннго проекта.

Необязательные опции:
-o, --out -     Путь для шаблоннго проекта, по умолчанию принимает дирректорию утилиты.

-b, --branch -  Ветка для зависимостей flutter-standard, по умолчанию "Dev".

-r, --remote -  Указать свой репозиторий для загрузки template,
                по умолчанию 'https://gitlab.com/surfstudio/public/flutter-standard.git'.

-h, --help  -   Показать help.

#### Exception

Exception: Enter project name -     не указано имя проекта.

Exception: git not found, install git of https://git-scm.com -  Не установлен GIT.