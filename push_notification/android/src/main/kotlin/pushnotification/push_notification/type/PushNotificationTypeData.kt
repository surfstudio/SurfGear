package pushnotification.push_notification.type

import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue
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
        var buttons: MutableList<PushNotificationAction> = mutableListOf()
        val test = map[BUTTONS]
        var test2: List<Map<String, String>>
        if (test != null) {
            test2 = ObjectMapper().readValue(test)
            test2.forEach { action ->
                buttons.add(PushNotificationAction(action[BUTTON_TEXT]
                        ?: EMPTY_STRING, action[BUTTON_URL] ?: EMPTY_STRING, action[BUTTON_ID]
                        ?: EMPTY_STRING))
            }
        }
        return PushNotificationData(map, map[IMAGE_URL] ?: EMPTY_STRING, map[TITLE]
                ?: EMPTY_STRING, map[BODY] ?: EMPTY_STRING, buttons)
    }

    companion object {
        const val IMAGE_URL = "imageUrl"
        const val TITLE = "title"
        const val BODY = "message"
        const val BUTTONS = "buttons"
        const val BUTTON_TEXT = "text"
        const val BUTTON_URL = "url"
        const val BUTTON_ID = "uniqueKey"
    }
}