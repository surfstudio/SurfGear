# convert certificate

Converts certificate to *.dart the binary file.

## Описание

Утилита создаёт файл *.dart с сертификатом.

### FAQ

Обязательные опции:
    -n, --name      -   Имя исходного сертификата.

Необязательные опции:
    -i, --input     -   Дирректория исходного сертификата, по умолчанию принимает директорию утилиты.
    -o, --out       -   Директория конвертированного сертификата, по умолчанию принимает директорию утилиты.
    -h, --help      -   Показать help.

#### Exception
    Exception:  Enter the name of the certificate. - не ввели имя исходного сертификата.
    Exception:  File certificate $path not found. - сертификат не найден в дирректории.
    Exception:  Certificate conversion error. -  ошибка при конвертации сертификата.