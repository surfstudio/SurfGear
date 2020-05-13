package pushnotification.push_notification.notification

import pushnotification.push_notification.type.PushNotificationAction
import java.io.Serializable

/**
 * Notification model
 *
 * @param notificationData custom data in notification
 */
class PushNotificationData(
        val notificationData: Map<String, String>, val imageUrl: String, val title: String, val body: String, val buttons: List<PushNotificationAction>
) : Serializable {
    override fun toString(): String {
        return "PushNotificationData(notificationData=$notificationData)"
    }
}

