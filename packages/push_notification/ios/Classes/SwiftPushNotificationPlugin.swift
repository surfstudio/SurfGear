import Flutter
import UIKit
import UserNotifications

// Channels and methods names
let CHANNEL = "surf_notification"
let CALL_SHOW = "show"
let CALL_INIT = "initialize"
let CALL_REQUEST = "request"
let CALLBACK_OPEN = "notificationOpen"
// Arguments names
let ARG_PUSH_ID = "pushId"
let ARG_TITLE = "title"
let ARG_BODY = "body"
let ARG_DATA = "data"

// Plugin to display notifications
@available(iOS 10.0, *)
public class SwiftPushNotificationPlugin: NSObject, FlutterPlugin, UNUserNotificationCenterDelegate {

    let notificationCenter = UNUserNotificationCenter.current()

     var channel :FlutterMethodChannel

    init(channel channel: FlutterMethodChannel) {
            self.channel = channel
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: registrar.messenger())
        let instance = SwiftPushNotificationPlugin(channel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! NSDictionary
        switch call.method{
        case CALL_INIT:
            initialize(args: args)
            break
        case CALL_SHOW:
            show(args: args)
            break;
        case CALL_REQUEST:
            requestPermissions(args: args)
            break;
        default:
            result(FlutterMethodNotImplemented)
            return
        }
    }

    // Initialize Notifications
    func initialize(args : NSDictionary) {
        //Implements a notification display while the program is running
        notificationCenter.delegate = self;

        // Read notification request request parameter
        let requestAlertPermission = args["requestAlertPermission"] as! Bool
        // Read request notification sound parameter
        let requestSoundPermission = args["requestSoundPermission"] as! Bool
        // Notification Options
        var options: UNAuthorizationOptions = []

        // Enable notifications if requestAlertPermission == true
        if requestAlertPermission {
            options.insert(.alert)
        }
        // Enable notification sound if requestSoundPermission == true
        if requestSoundPermission {
            options.insert(.sound)
        }

        // Permission request for notifications
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
                return
            }
        }
    }

    func requestPermissions(args: NSDictionary) {
        // TODO
    }

    // Show notifications
    func show(args: NSDictionary) {
        // Notification id
        let id: Int = args[ARG_PUSH_ID] as! Int
        // Notification title
        let title: String = args[ARG_TITLE] as! String
        // Notification body text
        let body: String = args[ARG_BODY] as! String
        // Data for notification
        var data: Dictionary<String, Any> = [:]

        if !(args[ARG_DATA] is NSNull){
            data = args[ARG_DATA] as! Dictionary<String, Any>
        }

        // The object in which previously received data is stored
        let content = UNMutableNotificationContent()

        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.userInfo = data

        /* Trigger when notification is displayed
           Now it is configured to show
           notification with a minimum delay without repetitions
        */
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let identifier = String(id)
        // Notification request
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        // Add notification to notificationCenter
        // After that, a notification is displayed
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }

    /*  Called when the application is in the foreground. We get a UNNotification object that contains the UNNotificationRequest request. In the body of the method, you need to make a completion handler call with a set of options to notify UNNotificationPresentationOptions
     */
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }

    /*  Used to select a tap action for notification. You get a UNNotificationResponse object that contains an actionIdentifier to define an action. The system identifiers UNNotificationDefaultActionIdentifier and UNNotificationDismissActionIdentifier are used when you need to open the application by tap on a notification or close a notification with a swipe.
     */
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {

        let notification = response.notification
        let notificationData = notification.request.content.userInfo

        channel.invokeMethod(CALLBACK_OPEN, arguments: notificationData)

        completionHandler()
    }
}
