# init project

Creating a project template.

## Описание

Утилита создаёт проект на основе шаблона.

### FAQ
Обязательные опции:

    -n, --name      -   Имя шаблоннго проекта.
    
    -r, --remote    -   Указать репозиторий для загрузки template.

Необязательные опции:

    -o, --out       -   Путь для шаблоннго проекта, по умолчанию принимает дирректорию утилиты.
    
    -b, --branch    -   Ветка для зависимостей flutter-standard, по умолчанию "Dev".
    
    -h, --help      -   Показать help.

#### Exception

    Exception: Enter project name.  -   Не указано имя проекта.
            
    Exception: Enter the URL of the remote repository.  -   Не указан путь до репозитория.
            
    Exception: git not found, install git of https://git-scm.com -  Не установлен GIT.