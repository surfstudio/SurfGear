[Main](../../main.md)

[Full article on Medium.](https://medium.com/surfstudio/setting-up-flavors-in-flutter-e455834818d4)

# Setting Up Flavors in Flutter

All steps already done in template.

You can change identifier in common.xcconfig.

The information below is accompanying.

### Android

 It’s really straightforward and by no means different from usual methods on Android.

 Here’s what you need at a minimum:

 ```groovy
 flavorDimensions "release-type"

    productFlavors {
        dev {
            dimension "release-type"
            applicationIdSuffix  ".dev"
            versionNameSuffix "-dev"
        }

        prod {
            dimension "release-type"
        }
    }
```

That’s it! Now you can easily run this command:
```
flutter run --flavor dev
```
on your Android device.

### iOS

1. Create two configurations.
1. Add suffix to the dev one.
1. Profit!


### Configuration files

There are two configurations in your projects: dev and prod.
Their contents are as follows:

```с
#include "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug-dev.xcconfig"
#include "Generated.xcconfig"
#include "common.xcconfig"

bundle_suffix=.dev
IDENTIFIER=$(identifier)$(bundle_suffix)
```

Create two configurations and add them to the following directories:
```
ios/Flutter/dev.xcconfig
ios/Flutter/prod.xcconfig
```

This can also be done through Xcode (even better — to add them as configuration files). 
**Right-click on Runner -> New File -> Configuration Settings File -> select the save location**.

Create one more configuration file, in which you will set the basic part of your RODUCT_BUNDLE_IDENTIFIER.

File contents are defined in a single line:
```
identifier=your.bundle.identifier
```

Include this file in other configs and set a new User Defined Variable IDENTIFIER:
```
#include "common.xcconfig"

IDENTIFIER=$(identifier)$(bundle_suffix)
```

### Build Configurations. Make it double

It’s time to get familiar with build configurations. In Xcode, open Runner.xcworkspace and select the Runner project.

Find ’+’ in the Configurations section and create four new configurations: two for Release and two for Debug adding a postfix with the name of your config and future app scheme.

Like this:

![configs](./img/configs.png)

Unfortunately, duplication of configurations is still necessary, since iOS build script is very sensitive to naming.



### Adding schemes

Apart from creating config files, you need to correctly configure application schemes — there will also be two of them.

![schemes](./img/schemes.png)

This one is really easy. Important note: choose the correct target — Runner.

Now, select Edit Scheme and add the necessary configurations to each of the scheme processes.

### Update variables

Now, let’s do some mouse work in Xcode. Select your target and click the Build Settings button:
![build_settings](./img/bs_step1.png)

Do a search for Product Bundle Identifier (the Packaging section):
![build_settings](./img/bs_step2.png)

Change values for all configs to:
```
$(IDENTIFIER)
```

![build_settings](./img/bs_step3.png)

Now go to Info.plist and remove bundle suffix from the identifier line, leaving only:
```
$(PRODUCT_BUNFLE_IDENTIFIER)
```

### Separate files for different Bundle IDs

...But you’ve decided to integrate analytics. If you use Firebase, you’ll need two projects and four apps respectively (two platforms for two versions).

Most importantly, you’ll need to have two google-services.json files (Google-Services.Info.plist). With Android, it’s easily managed: just create a folder with your flavor’s name and add your file there.

#### Creating and locating files

You need to create a new folder in the project to store these files. Use the following structure:

![dirs](./img/files_and_dirs.png)

**Important note**: do not create them via XCode. The files should not be mapped to the project. If Xcode is your favorite IDE, uncheck the Add to Targets checkbox when creating the files.

The next step is adding your files to the corresponding folders.

#### Adding files to the app at build time

Since the files are not mapped to the project, they won’t get into the target archive. You should add them here manually.

Add an extra build phase in the form of Run Script (let’s name it Setup Firebase, for example):
 ![build_phase](./img/build_phase.png)

 You need to pay attention to the location, it’s crucial.!

 Now, add the script. As an option, you can use the following one:

 ```
 # Name of the resource we're selectively copying
GOOGLESERVICE_INFO_PLIST=GoogleService-Info.plist

# Get references to dev and prod versions of the GoogleService-Info.plist
# NOTE: These should only live on the file system and should NOT be part of the target (since we'll be adding them to the target manually)
GOOGLESERVICE_INFO_DEV=${PROJECT_DIR}/${TARGET_NAME}/Firebase/dev/${GOOGLESERVICE_INFO_PLIST}
GOOGLESERVICE_INFO_PROD=${PROJECT_DIR}/${TARGET_NAME}/Firebase/prod/${GOOGLESERVICE_INFO_PLIST}

# Make sure the dev version of GoogleService-Info.plist exists
echo "Looking for ${GOOGLESERVICE_INFO_PLIST} in ${GOOGLESERVICE_INFO_DEV}"
if [ ! -f $GOOGLESERVICE_INFO_DEV ]
then
echo "No Development GoogleService-Info.plist found. Please ensure it's in the proper directory."
exit 1 # 1
fi

# Make sure the prod version of GoogleService-Info.plist exists
echo "Looking for ${GOOGLESERVICE_INFO_PLIST} in ${GOOGLESERVICE_INFO_PROD}"
if [ ! -f $GOOGLESERVICE_INFO_PROD ]
then
echo "No Production GoogleService-Info.plist found. Please ensure it's in the proper directory."
exit 1 # 1
fi

# Get a reference to the destination location for the GoogleService-Info.plist
PLIST_DESTINATION=${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app
echo "Will copy ${GOOGLESERVICE_INFO_PLIST} to final destination: ${PLIST_DESTINATION}"

# Copy over the prod GoogleService-Info.plist for Release builds
if [[ "${CONFIGURATION}" == *-prod ]]
then
echo "Using ${GOOGLESERVICE_INFO_PROD}"
cp "${GOOGLESERVICE_INFO_PROD}" "${PLIST_DESTINATION}"
else
echo "Using ${GOOGLESERVICE_INFO_DEV}"
cp "${GOOGLESERVICE_INFO_DEV}" "${PLIST_DESTINATION}"
fi
```





