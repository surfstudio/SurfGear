#import "InAppRatePlugin.h"
#if __has_include(<in_app_rate/in_app_rate-Swift.h>)
#import <in_app_rate/in_app_rate-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "in_app_rate-Swift.h"
#endif

@implementation InAppRatePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInAppRatePlugin registerWithRegistrar:registrar];
}
@end
