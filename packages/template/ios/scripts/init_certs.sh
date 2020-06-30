#!/bin/sh

# Add certificates to keychain and allow codesign to access them
security import ./certs/ios_development.cer -P "" -T /usr/bin/codesign #todo название файла сертификата
security import ./certs/ios_distribution.cer -P "" -T /usr/bin/codesign #todo название файла сертификата

output=~/Library/MobileDevice/Provisioning\ Profiles

if [[ ! -e "$output" ]]; then
    mkdir -p "$output"
fi

cp -R  ./certs/YOUR_PROVISIONING_PROFILE_DEV.mobileprovision "${output}" #todo название файла PP
cp -R  ./certs/YOUR_PROVISIONING_PROFILE_DISTRIBUTION.mobileprovision "${output}"#todo название файла PP