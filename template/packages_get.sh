#!/usr/bin/env bash
flutter packages get 
for dir in ./packages/*; do

    echo ${dir}
    cd ${dir}
    pwd
    flutter packages get
    cd ../..
    pwd
    shift
done
