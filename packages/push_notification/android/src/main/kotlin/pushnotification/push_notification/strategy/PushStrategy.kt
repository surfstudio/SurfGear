package pushnotification.push_notification.strategy

import android.app.Activity
import android.app.NotificationChannel
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat
import ru.surfstudio.android.notification.ui.notification.strategies.PushHandleStrategy
import pushnotification.push_notification.type.PushNotificationTypeData
import ru.surfstudio.android.utilktx.ktx.text.EMPTY_STRING
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL

/** Push strategy for [PushHandler]**/
class PushStrategy(override val icon: Int,
                   override val channelId: Int,
                   override val color: Int,
                   override val autoCancelable: Boolean,
                   override val channelName: Int,
                   private val imageUrl: String?
) : PushHandleStrategy<PushNotificationTypeData>() {

    override val typeData by lazy { PushNotificationTypeData() }

    override val contentView: RemoteViews? = null

    override fun makeNotificationBuilder(context: Context, title: String, body: String): NotificationCompat.Builder? {
        return NotificationCompat.Builder(context, context.getString(channelId))
                .setContentTitle(title)
                .setContentText(body)
                .setSmallIcon(icon)
                .setColor(ContextCompat.getColor(context, color))
                .setAutoCancel(autoCancelable)
                .setGroup(group?.groupAlias)
                .setContentIntent(pendingIntent)
                .applyLargeIcon(imageUrl)

    }

    override fun makeNotificationChannel(context: Context, title: String): NotificationChannel? = null

    override fun coldStartIntent(context: Context): Intent? {
        return null
    }

    override fun handlePushInActivity(activity: Activity): Boolean = false

}

private fun NotificationCompat.Builder.applyLargeIcon(imageUrl: String?): NotificationCompat.Builder = apply {
    if (imageUrl != null && imageUrl != EMPTY_STRING) {
        try {
            val bitmap = getBitmapFromURL(imageUrl)
            if (bitmap != null) {
                val bigPictureStyle = NotificationCompat.BigPictureStyle()
                        .bigPicture(bitmap)
                        .bigLargeIcon(null) // Hide small icon and show image
                setStyle(bigPictureStyle)
                setLargeIcon(bitmap)
            }
        } catch (e: Exception) {
            print("Error while downloading image")
        }

    }
}

private fun getBitmapFromURL(src: String?): Bitmap? {
    return try {
        val url = URL(src)
        val connection = url.openConnection() as HttpURLConnection
        connection.doInput = true
        connection.connect()
        val input = connection.inputStream
        BitmapFactory.decodeStream(input)
    } catch (e: IOException) { // Log exception
        null
    }
}
