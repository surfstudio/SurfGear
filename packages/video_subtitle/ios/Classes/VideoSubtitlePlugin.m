#import "VideoSubtitlePlugin.h"
#if __has_include(<video_subtitle/video_subtitle-Swift.h>)
#import <video_subtitle/video_subtitle-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "video_subtitle-Swift.h"
#endif

@implementation VideoSubtitlePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVideoSubtitlePlugin registerWithRegistrar:registrar];
}
@end
