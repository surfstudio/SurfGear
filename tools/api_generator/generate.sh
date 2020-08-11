#!/usr/bin/env bash

# Для генерации/перегенерации кода нужно:
# 1) положить template_api в корень проекта, дать необходимое имя, далее NAME
# 2) в open-generator-config.yaml указать pubName, совпадает с NAME
# 3) перейти в паку NAME, и выполнить скрипт ./generate.sh
#    передав первым параметром путь до спецификации, вторым если необходимо путь к файлу dartfmt,
#    входящему в Flutter SDK, необходим для форматирование сгенерированного кода

#    пример: ./generate.sh ../../rosbank-swagger/ros-api.yaml /Users/krasikov/development/flutter/bin/cache/dart-sdk/bin/dartfmt

# Сгенерированный код будет в паке NAME

if [ "$1" = "" ]; then
  echo 'First argument must be the swagger specification path'
  echo e.g. '../../rosbank-swagger/ros-api.yaml'
else

  rm -rf lib

  # Путь к файлу dartfmt, входящему в Flutter SDK, необходим для форматирование сгенерированного кода
  # формата: path -w
  if [ "$2" != "" ]; then
    echo DART_POST_PROCESS_FILE="$2 -w"

  fi
  java \
      -DapiTests=false \
      -DmodelTests=false \
      -DapiDocs=false \
      -DmodelDocs=false \
      -jar openapi-generator-cli.jar \
      generate \
      --input-spec $1 \
      --generator-name dart-jaguar \
      --config open-generator-config.yaml \
      --enable-post-process-file

  flutter pub get
  flutter pub run build_runner build
fi
