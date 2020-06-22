[Main](../main.md)

# Continious Delivery

To deliver artifacts to testers we use fastlane (responsible for unload)
and Beta by Fabric (build distribution service).

The build and deployment stages are written [here](./build.md).

This document describes how to configure Fabric.

The basic configuration for deployment to Beta is configured in a template project.
In a specific project, the following steps must be taken:

1. Create [organization in Fabric](https://www.fabric.io/settings/organizations)
1. Android:
    1. ./android/app/fabric.properties - add relevant API_KEY/API_SECRET
    1. ./android/fastlane/Fastfile - add relevant API_KEY/API_SECRET
    1. ./android/fastlane/Appfile - add relevant package-name
1. iOS:
    1. ./ios/Runner/Info.plist - add relevant API_KEY/API_SECRET into the necessary keys
    1. ./ios/fastlane/Appfile - add credentials
    1. ./ios/fastlane/Fastfile - add relevant API_KEY/API_SECRET and app_identifier
1. Stimulate a fatal error on one of the initial screens of the application.
1. Run the application on devices of both platforms. 

After these steps, two projects corresponding to the applications should appear in Fabric.