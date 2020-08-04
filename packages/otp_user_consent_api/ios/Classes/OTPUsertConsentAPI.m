#import "OtpTextEditControllerPlugin.h"
#if __has_include(<otp_text_edit_controller/otp_text_edit_controller-Swift.h>)
#import <otp_text_edit_controller/otp_text_edit_controller-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "otp_text_edit_controller-Swift.h"
#endif

@implementation OtpTextEditControllerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOtpTextEditControllerPlugin registerWithRegistrar:registrar];
}
@end
