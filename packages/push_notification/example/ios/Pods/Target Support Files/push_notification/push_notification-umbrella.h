#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "PushNotificationPlugin.h"

FOUNDATION_EXPORT double push_notificationVersionNumber;
FOUNDATION_EXPORT const unsigned char push_notificationVersionString[];

