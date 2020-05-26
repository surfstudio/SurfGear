package pushnotification.push_notification.type

import java.io.Serializable

/**
 * base push Action
 */
class PushNotificationAction(val text: String, val url: String, val id: String) : Serializable