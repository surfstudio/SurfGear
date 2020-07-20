package pushnotification.push_notification

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.AsyncTask
import androidx.annotation.NonNull
import io.fabric.sdk.android.services.network.HttpRequest
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar
import pushnotification.push_notification.handler.PushHandler
import pushnotification.push_notification.strategy.PushStrategy
import pushnotification.push_notification.strategy.SELECT_NOTIFICATION
import pushnotification.push_notification.type.PushNotificationTypeData
import ru.surfstudio.android.activity.holder.ActiveActivityHolder
import ru.surfstudio.android.notification.interactor.push.PushInteractor
import ru.surfstudio.android.notification.ui.PushClickProvider
import ru.surfstudio.android.notification.ui.PushEventListener
import ru.surfstudio.android.notification.ui.notification.NOTIFICATION_DATA
import ru.surfstudio.android.utilktx.ktx.text.EMPTY_STRING
import java.io.BufferedInputStream
import java.io.ByteArrayOutputStream
import java.io.OutputStream
import java.io.OutputStreamWriter
import java.net.HttpURLConnection
import java.net.URL


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

private const val MESSAGE_KEY = "uniqueKey"
private const val BUTTON_KEY = "buttonKey"

/** PushNotificationPlugin */
public class PushNotificationPlugin() : MethodCallHandler, FlutterPlugin, PluginRegistry.NewIntentListener, ActivityAware {
    private val activeActivityHolder = ActiveActivityHolder()
    private val pusInteractor = PushInteractor()

    private var mainActivity: Activity? = null
    private var context: Context? = null
    private var channel: MethodChannel? = null

    private val pushHandler = PushHandler(activeActivityHolder, pusInteractor)

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar): Unit {
            val plugin = PushNotificationPlugin()
            plugin.onAttachedToEngine(registrar.context(), registrar.messenger())
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        binding.addOnNewIntentListener(this)
        sendNotificationPayloadMessage(binding.getActivity().intent)
        mainActivity = binding.getActivity()
    }

    override fun onDetachedFromActivityForConfigChanges() {
        mainActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        binding.addOnNewIntentListener(this)
        mainActivity = binding.getActivity()
    }

    override fun onDetachedFromActivity() {
        mainActivity = null
    }

    override fun onNewIntent(intent: Intent): Boolean {
        val res = sendNotificationPayloadMessage(intent)
        if (mainActivity != null) {
            mainActivity!!.intent = intent
        }
        return true;
    }

    private fun onAttachedToEngine(context: Context, binaryMessenger: BinaryMessenger) {
        this.context = context
        channel = MethodChannel(binaryMessenger, CHANNEL)
        channel?.setMethodCallHandler(this)
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger())
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {}

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

    private fun sendNotificationPayloadMessage(intent: Intent): Boolean? {
        if (Intent.ACTION_VIEW.equals(intent.action)) {
            val notificationTypeData = intent.getSerializableExtra(NOTIFICATION_DATA) as PushNotificationTypeData?

            if (notificationTypeData != null) {
                var notificationData = HashMap<String, String>();
                if (notificationTypeData.data != null) {
                    notificationData = HashMap(notificationTypeData.data?.notificationData)
                    sendClickOperation(notificationData)
                }

                channel!!.invokeMethod(CALLBACK_OPEN, notificationData)
            }
            return true
        }
        return false
    }

    private fun initNotificationTapListener() {
        PushClickProvider.pushEventListener = object : PushEventListener {
            override fun pushDismissListener(context: Context, intent: Intent) {
                channel!!.invokeMethod(CALLBACK_DISMISS, null)
            }

            override fun pushOpenListener(context: Context, intent: Intent) {
                /**todo пуш открывает приложение только в свернутом виде
                 * если выгрузить приложение пуш по тапу ничего не делает **/
                val notificationTypeData = intent.getSerializableExtra(NOTIFICATION_DATA) as PushNotificationTypeData

                //TODO: Разобраться, почему не приходит NOTIFICATION_DATA
                var notificationData = HashMap<String, String>();
                if (notificationTypeData.data != null) {
                    notificationData = HashMap(notificationTypeData.data?.notificationData)
                }
                channel!!.invokeMethod(CALLBACK_OPEN, notificationData)
            }
        }
    }

    private fun handleNotification(args: Map<String, *>) {
        AsyncTask.execute {
            val notificationSpecifics = args[ARG_SPECIFICS] as HashMap<String, *>
            val icon = notificationSpecifics[ARG_ICON] as String? ?: DEFAULT_ICON_NAME
            val channelId = notificationSpecifics[ARG_CHANNEL_ID] as String? ?: DEFAULT_CHANNEL_ID
            val channelName = notificationSpecifics[ARG_CHANNEL_NAME] as String?
                    ?: DEFAULT_CHANNEL_NAME
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
    }

    private fun getResourceId(resName: String, defType: String): Int {
        return context!!.resources.getIdentifier(resName, defType, context!!.packageName)
    }

    private fun sendClickOperation(notificationData: Map<String, String>) {
        val messageUniqueKey: String = notificationData[MESSAGE_KEY]
                ?: ""
        // Реализовать добавление уникального идентификатора кнопки
        val buttonUniqueKey: String? = null
        if (messageUniqueKey != "") {
            AsyncTask.execute {
                // Отправка операции нажатия на пуш
                var url = URL("https://api.mindbox.ru/v3/mobile-push/click?endpointId=2020RiglaMobileAndroid")

                var conn = url.openConnection() as HttpURLConnection
                conn.requestMethod = "POST";
                conn.doInput = true;
                conn.doOutput = true;
                conn.setRequestProperty("Content-Type", "application/json")
                conn.setRequestProperty("Accept", "application/json");

                var body: String = if (buttonUniqueKey != null) {
                    "{\"click\":{\"messageUniqueKey\": \"$messageUniqueKey\", \"buttonUniqueKey\" :\"$buttonUniqueKey\"}}"
                } else {
                    "{ \"click\":{\"messageUniqueKey\": \"$messageUniqueKey\"}}"
                }
                conn.doOutput = true
                val os: OutputStream = conn.outputStream
                os.write(body.toByteArray())
                os.close()
                conn.connect()

                print(conn.responseCode)
            }
        }
    }
}
