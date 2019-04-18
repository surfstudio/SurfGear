#import "TemplatePlugin.h"
#import <template/template-Swift.h>

@implementation TemplatePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTemplatePlugin registerWithRegistrar:registrar];
}
@end
