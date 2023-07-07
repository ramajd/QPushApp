#import "UIKit/UIKit.h"

#include "../src/notificationhandler.h"

@interface QIOSApplicationDelegate
@end

@interface QIOSApplicationDelegate (NotificationDelegate)
@end

@implementation QIOSApplicationDelegate (NotificationDelegate)

-(BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];

    [application registerForRemoteNotifications];
    NotificationHandler::Instance()->submitLog(QString::fromNSString(@"registered for remote notifications"));
    return YES;
}

-(void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSString *tokenStr = [deviceToken base64EncodedStringWithOptions:0];
//    NotificationHandler::Instance()->setToken(QString::fromNSString(tokenStr));
    NotificationHandler::Instance()->setToken(QByteArray::fromNSData(deviceToken));
    NotificationHandler::Instance()->submitLog(QString::fromNSString(@"device token received"));
}

-(void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *errorMessage = [error localizedDescription];
    NotificationHandler::Instance()->submitError(QString::fromNSString(errorMessage));
}

@end

