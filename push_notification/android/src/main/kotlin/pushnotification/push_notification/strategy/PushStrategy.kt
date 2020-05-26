package pushnotification.push_notification.strategy

import android.app.Activity
import android.app.NotificationChannel
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat
import pushnotification.push_notification.notification.PushNotificationData
import pushnotification.push_notification.type.PushNotificationTypeData
import ru.surfstudio.android.notification.ui.notification.*
import ru.surfstudio.android.notification.ui.notification.strategies.PushHandleStrategy
import ru.surfstudio.android.utilktx.ktx.text.EMPTY_STRING
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL


const val SELECT_NOTIFICATION = "SELECT_NOTIFICATION"

/** Push strategy for [PushHandler]**/
class PushStrategy(override val icon: Int,
                   override val channelId: Int,
                   override val color: Int,
                   override val autoCancelable: Boolean,
                   override val channelName: Int
) : PushHandleStrategy<PushNotificationTypeData>() {

    override val typeData by lazy { PushNotificationTypeData() }

    override val contentView: RemoteViews? = null

    override fun makeNotificationBuilder(context: Context, title: String, body: String): NotificationCompat.Builder? {
        val data = typeData.data

        val intent = Intent(context, getMainActivityClass(context))
        intent.action = SELECT_NOTIFICATION
        intent.putExtra(NOTIFICATION_DATA, typeData)
        val newPendingIntent = PendingIntent.getActivity(context, typeData.hashCode(), intent, PendingIntent.FLAG_UPDATE_CURRENT)

        return NotificationCompat.Builder(context, context.getString(channelId))
                .setSmallIcon(icon)
                .setContentTitle(data?.title)
                .setContentText(data?.body)
                .setGroupSummary(true)
                .setColor(ContextCompat.getColor(context, color))
                .setContent(contentView)
                .setAutoCancel(autoCancelable)
                .setContentIntent(newPendingIntent)
                //TODO: Вернуть информацию о кнопках, когда нужна будет реализация
//                .addActions(context, data)
                .applyLargeIcon(context, data)
//                .setDeleteIntent(deleteIntent)
    }

    private fun getMainActivityClass(context: Context): Class<*>? {
        val packageName = context.packageName
        val launchIntent = context.packageManager.getLaunchIntentForPackage(packageName)
        val className = launchIntent.component.className
        return try {
            Class.forName(className)
        } catch (e: ClassNotFoundException) {
            e.printStackTrace()
            null
        }
    }

    override fun makeNotificationChannel(context: Context, title: String): NotificationChannel? = null

    override fun coldStartIntent(context: Context): Intent? {
        return null
    }

    override fun handlePushInActivity(activity: Activity): Boolean = false

    private fun NotificationCompat.Builder.addActions(
            context: Context,
            notification: PushNotificationData?
    ): NotificationCompat.Builder = apply {
        if (notification?.buttons?.isNotEmpty() == true) {
            notification.buttons.forEach { button ->
                val actionIntent = Intent(context, NotificationClickEventReceiver::class.java)
                actionIntent.putExtra(NOTIFICATION_DATA, typeData)
                actionIntent.putExtra("ACTION", button.id)
                addAction(0, button.text, PendingIntent.getBroadcast(context.applicationContext, button.text.hashCode(), actionIntent, PendingIntent.FLAG_ONE_SHOT))
            }
        }
    }

    private fun NotificationCompat.Builder.applyLargeIcon(
            context: Context,
            notification: PushNotificationData?
    ): NotificationCompat.Builder = apply {
        if (notification != null && notification.imageUrl != EMPTY_STRING) {
            try {
                val bitmap = getBitmapFromURL(notification.imageUrl)
                val bigPictureStyle = NotificationCompat.BigPictureStyle()
                        .bigPicture(bitmap)
                        .bigLargeIcon(null) // Чтобы при разворачивании уведопления инонка исчезала, а изображение появлялось
                setStyle(bigPictureStyle)
                setLargeIcon(bitmap)
            } catch (e: Exception) {
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
}