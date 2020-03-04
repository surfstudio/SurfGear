#!/bin/sh

# Add certificates to keychain and allow codesign to access them
security import ./certs/ios_development.cer -T /usr/bin/codesign #todo название файла сертификата
# security import ./certs/dev.p12 -P "" -T /usr/bin/codesign
security import ./certs/ios_distribution.cer -T /usr/bin/codesign #todo название файла сертификата
# security import ./certs/distr.p12 -P "" -T /usr/bin/codesign

output=~/Library/MobileDevice/Provisioning\ Profiles

cp -R  ./certs/YOUR_PROVISIONING_PROFILE_DEV.mobileprovision "${output}" #todo название файла PP
# cp -R  ./certs/iOS_Prod_Development.mobileprovision "${output}"
cp -R  ./certs/YOUR_PROVISIONING_PROFILE_DISTRIBUTION.mobileprovision "${output}"#todo название файла PP