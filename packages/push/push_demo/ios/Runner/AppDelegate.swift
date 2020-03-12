import UIKit
import Flutter
import UserNotifications

//@available(iOS 10.0, *)
//class NotificationTest : NSObject, UNUserNotificationCenterDelegate {
//    /*  Вызывается, когда приложение находится на переднем плане. Мы получаем объект UNNotification, который содержит запрос UNNotificationRequest. В теле метода необходимо выполнить вызов completion handler с набором опций для оповещения UNNotificationPresentationOptions
//       */
//      public func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                         willPresent notification: UNNotification,
//                                         withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//          completionHandler([.alert,.sound])
//      }
//
//      /*  Используется, для выбора действия по тапу на уведомление. Вы получаете объект UNNotificationResponse, который содержит в себе actionIdentifier для определения того или иного действия. Системные идентификаторы UNNotificationDefaultActionIdentifier и UNNotificationDismissActionIdentifier используются, когда нужно открыть приложение по тапу на уведомление или закрыть уведомление свайпом.*/
//      public func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                         didReceive response: UNNotificationResponse,
//                                         withCompletionHandler completionHandler: @escaping () -> Void) {
//
//          var data: [String: String] = ["key":"world"]
//        let notification = response.notification;
//        notification.request.content.userInfo;
//          completionHandler()
//      }
//}
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
//    var channel :FlutterMethodChannel
//    init(channel channel: FlutterMethodChannel) {
//        self.channel = channel
//    }
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
//    var channel :FlutterMethodChannel
//    var data: [String: String] = ["hello":"world"]
//    channel.invokeMethod("notificationOpen", arguments: data)
//    let dict: Dictionary<String, Any> = Dictionary()
//    var a : Stirng = "d"
//    if(a == nil){
//        a = "d"
//    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
