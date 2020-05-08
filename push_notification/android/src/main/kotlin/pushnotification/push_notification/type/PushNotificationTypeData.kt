package pushnotification.push_notification.type

import pushnotification.push_notification.notification.PushNotificationData
import ru.surfstudio.android.notification.interactor.push.BaseNotificationTypeData
import ru.surfstudio.android.utilktx.ktx.text.EMPTY_STRING

/**
 * Push type with data
 */
class PushNotificationTypeData : BaseNotificationTypeData<PushNotificationData>() {

    /**todo Данные из флаттера могут приходить в любом формате, не только в строках
     * необходимо в [BaseNotificationTypeData] в методе setDataFromMap поменять параметр String
     * на dymamic**/
    override fun extractData(map: Map<String, String>): PushNotificationData? {
        return PushNotificationData(map, map[IMAGE_URL] ?: EMPTY_STRING, map[TITLE]
                ?: EMPTY_STRING, map[BODY] ?: EMPTY_STRING)
    }

    companion object {
        const val IMAGE_URL = "imageUrl"
        const val TITLE = "title"
        const val BODY = "message"
    }

}