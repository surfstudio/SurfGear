package pushnotification.push_notification.handler

import android.content.Context
import ru.surfstudio.android.activity.holder.ActiveActivityHolder
import ru.surfstudio.android.notification.interactor.push.PushInteractor
import pushnotification.push_notification.strategy.PushStrategy

/** Push notification handler **/
class PushHandler(
        private val activeActivityHolder: ActiveActivityHolder,
        private val pushInteractor: PushInteractor
) {

    fun handleMessage(context: Context,
                      uniqueId: Int,
                      title: String,
                      body: String,
                      pushHandleStrategy: PushStrategy) {
        val activity = activeActivityHolder.activity
        pushHandleStrategy.handle(
                context = activity ?: context,
                pushInteractor = pushInteractor,
                uniqueId = uniqueId,
                title = title,
                body = body
        )
    }
}

