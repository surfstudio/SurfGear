package push.push

import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import push.push.handler.PushHandler
import push.push.strategy.PushStrategy
import push.push.type.PushNotificationTypeData
import ru.surfstudio.android.activity.holder.ActiveActivityHolder
import ru.surfstudio.android.notification.interactor.push.PushInteractor
import ru.surfstudio.android.notification.ui.PushClickProvider
import ru.surfstudio.android.notification.ui.PushEventListener
import ru.surfstudio.android.notification.ui.notification.NOTIFICATION_DATA
import ru.surfstudio.android.utilktx.ktx.text.EMPTY_STRING

//channels and methods names
private const val CHANNEL = "surf_notification"
private const val CALL_SHOW = "show"
private const val CALL_INIT = "initialize"
private const val CALLBACK_OPEN = "notificationOpen"
private const val CALLBACK_DISMISS = "notificationDismiss"
//resource folder names
private const val FOLDER_DRAWABLE = "drawable"
private const val FOLDER_STRING = "string"
private const val FOLDER_COLOR = "color"
///arguments names
private const val ARG_SPECIFICS = "notificationSpecifics"
private const val ARG_ICON = "icon"
private const val ARG_CHANNEL_ID = "channelId"
private const val ARG_CHANNEL_NAME = "channelName"
private const val ARG_COLOR = "color"
private const val ARG_DATA = "data"
private const val ARG_PUSH_ID = "pushId"
private const val ARG_TITLE = "title"
private const val ARG_BODY = "body"
private const val ARG_AUTOCANCELABLE = "autoCancelable"
// default notification specifics
private const val DEFAULT_ICON_NAME = "@mipmap/ic_launcher"
private const val DEFAULT_CHANNEL_ID = "@string/notification_channel_id"
private const val DEFAULT_CHANNEL_NAME = "@string/data_push_channel_name"
private const val DEFAULT_COLOR = "@color/design_default_color_primary"
private const val DEFAULT_AUTOCANCEL = true

/** SurfNotificationPlugin */
public class PushPlugin(private var context: Context? = null,
                        private var channel: MethodChannel? = null
) : FlutterPlugin, MethodCallHandler {

    private val activeActivityHolder = ActiveActivityHolder()
    private val pusInteractor = PushInteractor()

    private val pushHandler = PushHandler(activeActivityHolder, pusInteractor)

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, CHANNEL)
        channel.setMethodCallHandler(PushPlugin(flutterPluginBinding.applicationContext, channel))
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        val args = call.arguments as Map<String, *>?

        when (call.method) {
            CALL_INIT -> {
                initNotificationTapListener()
            }
            CALL_SHOW -> handleNotification(args!!)
            else -> result.notImplemented()
        }
    }

    private fun initNotificationTapListener() {
        PushClickProvider.pushEventListener = object : PushEventListener {
            override fun pushDismissListener(context: Context, intent: Intent) {
                channel!!.invokeMethod(CALLBACK_DISMISS, null)
            }

            override fun pushOpenListener(context: Context, intent: Intent) {
                val notificationTypeData = intent.getSerializableExtra(NOTIFICATION_DATA) as PushNotificationTypeData
                val notificationData = HashMap(notificationTypeData.data?.notificationData)

                channel!!.invokeMethod(CALLBACK_OPEN, notificationData)
            }
        }
    }

    private fun handleNotification(args: Map<String, *>) {
        val notificationSpecifics = args[ARG_SPECIFICS] as HashMap<String, *>
        val icon = notificationSpecifics[ARG_ICON] as String? ?: DEFAULT_ICON_NAME
        val channelId = notificationSpecifics[ARG_CHANNEL_ID] as String? ?: DEFAULT_CHANNEL_ID
        val channelName = notificationSpecifics[ARG_CHANNEL_NAME] as String? ?: DEFAULT_CHANNEL_NAME
        val color = notificationSpecifics[ARG_COLOR] as String? ?: DEFAULT_COLOR
        val autoCancelable: Boolean = notificationSpecifics[ARG_AUTOCANCELABLE] as Boolean?
                ?: DEFAULT_AUTOCANCEL

        val data = args[ARG_DATA] as HashMap<String, String>?

        val strategy = PushStrategy(
                icon = getResourceId(icon, FOLDER_DRAWABLE),
                channelId = getResourceId(channelId, FOLDER_STRING),
                channelName = getResourceId(channelName, FOLDER_STRING),
                color = getResourceId(color, FOLDER_COLOR),
                autoCancelable = autoCancelable)

        if (data != null) {
            strategy.typeData.setDataFromMap(data)
        }

        pushHandler.handleMessage(context!!,
                uniqueId = args[ARG_PUSH_ID] as Int? ?: -1,
                title = args[ARG_TITLE] as String? ?: EMPTY_STRING,
                body = args[ARG_BODY] as String? ?: EMPTY_STRING,
                pushHandleStrategy = strategy
        )
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {}

    private fun getResourceId(resName: String, defType: String): Int {
        return context!!.resources.getIdentifier(resName, defType, context!!.packageName)
    }

}

