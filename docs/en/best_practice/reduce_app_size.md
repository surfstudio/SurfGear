[Main](../main.md)

# Reduce application size

## Android

Files 
Files taking up the most space in build:
- `libflutter.so` - run-time framework's library. Flutter team promises to optimize the size of this file in future versions, or to put it in a separately installed run-time package; 
- `libapp.so` - compiled application;
- `classes.dex` - Native part of used libraries in one file. Most libraries have already passed through an obfuscator;
- catalog `res` - system resources, such like Material and Cupertino icons, assets collection from project catalog;
- others in the amount of less than 1% of size;

Files `libflutter.so` and `libapp.so` included in all builds for all supported platform, so if try to build one for x86, x86_64, armeabiv7a, arm64_v8a, then build occupies much more space.
Another choice is to start build with argument `--split-per-abi`:
```
flutter build apk --split-per-abi
```
In this case we have a few separeted builds, one for each platform, each bilds take less then 10 Mb for release.

### App Bundles

Aab-file is a download format, that content all compiled code and resources of application iin one build artifact.

If start build with argument - App Bundles:
```
flutter build appbundle
```
then it compiled to `*.aab` file, wich size correspond to fat apk-file.

If you need to distribute the application via Google Play, then it is more profitable to use an aab-file.
Because, in this case, after downloading the signed application package on Google Play, there is everything you need,
to create and sign application apk files and provide them to users through dynamic delivery.
That is, the user will download the apk file from Google Play, which will contain binary files of only one, the required platform.

If the application is distributed using other services, or simply by transferring files, then there is no point in transferring an aab file,
because it cannot be installed on the device.
Using utilities, you need to prepare from it either a fat apk file for all platforms, or separate apk files for different platforms.
In this case, it is easier to use the apk assembly with the argument `--split-per-abi`.

The steps of the flutter team over the release build size of the application can be observed [there](https://github.com/flutter/flutter/issues/16833)
The flutter team periodically reduce size of `libflutter.so` by optimizing the libraries used and by using the latest versions
a compiler that generates more compact code.


## iOS
Application build for iOS is larger than build for same application for Android.
Mainly because Apple encrypts binary files within the IPA, making compression less efficient.

The general recommendation is to prefer loading large data from assets instead of declaring static constants in the code.

Apple has taken care to partially download application updates from the App Store.
Quote from the knowledge base:
```
For devices running iOS 7.1 and later, the service pack may only contain differences
between the old and new versions of the modified file, not the full file. This can significantly reduce the package size.
updates if only a small part of the large file is changed, but the update installation time will increase
on the device.
```


## Resources

What data format to prefer for storing graphic files?

- `PNG` - format for the presentation of raster images, has its own, sufficient effective compression.
- `JPG` - format for the presentation of raster images, has its own, sufficient effective compression. 
    It is preferable to use the `PNG` format, since the `JPG` format has lossy compression and artifacts may be noticeable on the image.
- `SVG` - presentation format of vector images, basically it has a text format, is compressed inside the assembly artifact.
- `TTF` - the font file format that can be created from a set of svg files, the binary format is compressed inside the assembly artifact.
    To get a font file from a set of svg files, you can use [utility](https://github.com/ilikerobots/polyicon)
- `FLR` - Flare animation format, it is text format that compressed inside the assembly artifact

None of the listed formats gives a significant advantage in the amount of information stored inside the assembly artifact.

The general recommendation is to prefer loading large data from assets instead of declaring static constants in the code.


## Obfuscated Dart Code

On the example of a real application (ROS) size of fat apk:

- without obfuscation - 16 131 443 B
- with obfuscation - 16 031 895 B

However, the obfuscation gives some more side effects.
For example, printing a string representation of an object type, a stack trace, and more,
will behave a little differently than expected from a Dart program running in normal mode - because the identifiers will be distorted.

All identifiers that return methods, such as:
Object.runtimeType, 
Type.toString, 
Enum.toString, 
Stacktrace.toString, 
Symbol.toString, 
will return distorted results. Any code or tests that rely on the result of these functions will stop working.

However, for example, to decrypt the stack trace, you can add the argument
`--save-obfuscation-map=<filename>` which forces the VM to store the mapping between the original names and the distorted ones in the given `filename`.
The mapping is encoded as a JSON array `[original_name_0, obfuscated_name_0, original_name_1, obfuscated_name_1, ...]`.
