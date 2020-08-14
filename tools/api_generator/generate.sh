#!/usr/bin/env bash

# Для генерации/перегенерации кода нужно:
# 1) положить template_api в корень проекта, дать необходимое имя, далее NAME
# 2) в open-generator-config.yaml указать pubName, совпадает с NAME
# 3) перейти в паку NAME, и выполнить скрипт ./generate.sh
#    передав первым параметром путь до спецификации

# Сгенерированный код будет в паке NAME

if [ "$1" = "" ]; then
  echo 'First argument must be the swagger specification path'
  echo e.g. '../../rosbank-swagger/ros-api.yaml'
else

  rm -rf lib
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
  flutter format .
fi
