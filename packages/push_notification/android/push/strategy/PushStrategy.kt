package push.push.strategy

import android.app.Activity
import android.app.NotificationChannel
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import androidx.core.app.NotificationCompat
import ru.surfstudio.android.notification.ui.notification.strategies.PushHandleStrategy
import push.push.type.PushNotificationTypeData

/** Push strategy for [PushHandler]**/
class PushStrategy(override val icon: Int,
                   override val channelId: Int,
                   override val color: Int,
                   override val autoCancelable: Boolean,
                   override val channelName: Int
) : PushHandleStrategy<PushNotificationTypeData>() {

    override val typeData by lazy { PushNotificationTypeData() }

    override val contentView: RemoteViews? = null

    override fun makeNotificationBuilder(context: Context, title: String, body: String): NotificationCompat.Builder? = null
    override fun makeNotificationChannel(context: Context, title: String): NotificationChannel? = null

    override fun coldStartIntent(context: Context): Intent? {
        return null
    }

    override fun handlePushInActivity(activity: Activity): Boolean = false

}