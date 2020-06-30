//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<notification_permissions/NotificationPermissionsPlugin.h>)
#import <notification_permissions/NotificationPermissionsPlugin.h>
#else
@import notification_permissions;
#endif

#if __has_include(<permission_handler/PermissionHandlerPlugin.h>)
#import <permission_handler/PermissionHandlerPlugin.h>
#else
@import permission_handler;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [NotificationPermissionsPlugin registerWithRegistrar:[registry registrarForPlugin:@"NotificationPermissionsPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
}

@end
