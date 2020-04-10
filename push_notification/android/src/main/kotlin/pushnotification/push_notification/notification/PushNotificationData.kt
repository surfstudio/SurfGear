package pushnotification.push_notification.notification

import java.io.Serializable

/**
 * Notification model
 *
 * @param notificationData custom data in notification
 */
class PushNotificationData(
        val notificationData: Map<String, String>
) : Serializable {
    override fun toString(): String {
        return "PushNotificationData(notificationData=$notificationData)"
    }
}

