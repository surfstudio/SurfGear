#import "PushNotificationPlugin.h"
#if __has_include(<push_notification/push_notification-Swift.h>)
#import <push_notification/push_notification-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "push_notification-Swift.h"
#endif

@implementation PushNotificationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPushNotificationPlugin registerWithRegistrar:registrar];
}
@end
