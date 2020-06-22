[Main](../main.md)

# Initializing a project from Template

For quick initialization of a new Flutter project, there is a special
Template.
You have a few simple steps to do:

1. Create a folder for the repository with the name of the project. Folder Name =
GitLab repository name;
1. Copy the contents of the folder  ***/template*** from **flutter-standard** 
to the directory created in the previous step;
1. In file ***pubspec.yaml*** set `name` of your application (not
may contain hyphens). **IMPORTENT:** this is not the package-name of your application. 
Real package-name is set separately for each platform.
and may vary;
1. Replace the string `flutter_template` throughout the project *(Ctrl+Shift+R)*
 on the `name` of the application specified in the previous step.

### Common:

A project cannot be built without **Firebase** and **Fabric** projects created. 
In case these projects must be created on the customer side,
but not yet, the right solution would be to create a temporary project in
account surfstudio36@gmail.com ([you can find out the password here](https://docs.google.com/document/d/13BpXmgwBrbrliGxn80Mr70E2D3NIEdRcybpWLuHzzco/edit)).

1. It is necessary to create a project which will contain 4 applications
(**Android** - *prod* and *dev*, **iOS** - *prod* and *dev*);
1. **Android:** Download `google-services.json` (common to all types
builds) and put it in `android/app`;
1. **iOS:** Download two `GoogleService-Info.plist` (for each type
build) and put it in `ios/Runner/Firebase/dev` and `ios/Runner/Firebase/prod`;

You can read more about setting up a CD [here](./cd.md).

### Android:
1. In **AndroidManifest.xml** replace `package` on package-name for
Android application builds. **IMPORTANT:** there are three manifest files in the project
(`app/src/debug`, `app/src/main`, `app/src/profile`), update
package-name is needed in each;
1. Change the path to `MainActivity` to match the application's package-name;
1. Run the console command `flutter packages get`.

<br>Flavors are pre-configured, no additional action is required.

### iOS:
1. Open file `ios/Flutter/common.xcconfig`;
1. Replace there `identifier` with the package-name of your application.