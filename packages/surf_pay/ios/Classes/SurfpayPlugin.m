#import "SurfpayPlugin.h"
#if __has_include(<surfpay/surfpay-Swift.h>)
#import <surfpay/surfpay-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "surfpay-Swift.h"
#endif

@implementation SurfpayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSurfpayPlugin registerWithRegistrar:registrar];
}
@end
