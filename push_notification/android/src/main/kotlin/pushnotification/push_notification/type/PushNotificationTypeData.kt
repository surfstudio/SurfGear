package pushnotification.push_notification.type

import pushnotification.push_notification.notification.PushNotificationData
import ru.surfstudio.android.notification.interactor.push.BaseNotificationTypeData

/**
 * Push type with data
 */
class PushNotificationTypeData : BaseNotificationTypeData<PushNotificationData>() {

    /**todo Данные из флаттера могут приходить в любом формате, не только в строках
     * необходимо в [BaseNotificationTypeData] в методе setDataFromMap поменять параметр String
     * на dymamic**/
    override fun extractData(map: Map<String, String>): PushNotificationData? = PushNotificationData(map)
}