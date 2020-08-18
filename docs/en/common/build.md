[Main](../main.md)

# Build/deploy project

## Set SDK version

In most cases, all projects use the same SDK version in stable.
This version must be installed in the file [./script/version.sh](../../../template/script/version)

```
current_version=*sdk version*
```

## Build

Scripts from the /script directory are provided for building artifacts.
Their execution takes place on Jenkins with Pr and Tag jobs.
It is also possible to manually execute scripts from the console.

- ./script/android/build.sh - build qa/release (x64)
- ./script/ios/build.sh - ios build 
- ./script/version.sh - checkout Flutter SDK version for prokect

**IMPORTANT**: All commands execute from **project's** root (where the pubspec.yaml of application is located)

**IMPORTANT**: Before IOs build is necessary

* Download certificates from Apple Account and Provisioning Profile and put them in a folder `./ios/certs`
* Fill todo in script `./ios/scripts/init_certs.sh`

* Execute following commands:

```
make -C ios/ init
```

In case of unclear errors (актуально для iOS сборок):

1. Quite Xcode
1. Disconnect devices
1. Clear project:
```
./clean_ios.sh
```

1. Repeat all the steps to build the project


## Deployment artifacts 

To deploy artifacts we use **Beta by Fabric**.
To upload Build in this service, fastlane is used.

Basically commands:

```
cd android/; fastlane android beta //android build

make -C ios beta //ios build
```

**IMPORTANT**: When uploading locally before it, you should build the project using one of the described
above build scripts.
