package ru.surfstudio.otp_text_edit_controller

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import androidx.annotation.NonNull;
import com.google.android.gms.auth.api.credentials.Credential
import com.google.android.gms.auth.api.credentials.Credentials
import com.google.android.gms.auth.api.credentials.HintRequest
import com.google.android.gms.auth.api.phone.SmsRetriever

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar

/// Requests
const val credentialPickerRequest = 1
const val smsConsentRequest = 2

/// Methods
const val getTelephoneHint: String = "getTelephoneHint"
const val startListenForCode: String = "startListenForCode"

const val onCodeCallback: String = "onCodeCallback"

/// Arguments
const val senderTelephoneNumber: String = "senderTelephoneNumber"

/** OtpTextEditControllerPlugin */
public class OtpTextEditControllerPlugin : FlutterPlugin, MethodCallHandler, PluginRegistry.ActivityResultListener, ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity
    private lateinit var smsBroadcastReceiver: SmsBroadcastReceiver

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "otp_text_edit_controller")
        channel.setMethodCallHandler(this);
    }

    companion object {
        private var context: Context? = null
        private var resultForHint: Result? = null

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            context = registrar.context()
            val channel = MethodChannel(registrar.messenger(), "otp_text_edit_controller")
            val plugin = OtpTextEditControllerPlugin()
            channel.setMethodCallHandler(plugin)
            registrar.addActivityResultListener(plugin)
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            startListenForCode -> {
                listenForCode(call, result)
            }
            getTelephoneHint -> {
                showNumberHint(result)
            }
            else -> result.notImplemented()
        }
    }

    private fun showNumberHint(result: Result) {
        resultForHint = result

        val hintRequest = HintRequest.Builder()
                .setPhoneNumberIdentifierSupported(true)
                .build()
        val credentialsClient = Credentials.getClient(activity)
        val intent = credentialsClient.getHintPickerIntent(hintRequest)
        activity.startIntentSenderForResult(
                intent.intentSender,
                credentialPickerRequest,
                null, 0, 0, 0
        )
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        when (requestCode) {
            smsConsentRequest ->
                // Obtain the phone number from the result
                if (resultCode == Activity.RESULT_OK && data != null) {
                    // Get SMS message content
                    val message = data.getStringExtra(SmsRetriever.EXTRA_SMS_MESSAGE)
                    channel.invokeMethod(onCodeCallback, message)
                } else {
                    // Consent denied. User can type OTC manually.
                }
            credentialPickerRequest -> if (resultCode == Activity.RESULT_OK && data != null) {
                val credential = data.getParcelableExtra<Credential>(Credential.EXTRA_KEY)
                resultForHint?.success(credential.getId())
            }
        }
        return true
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity
        binding.addActivityResultListener(this)
        registerToSmsBroadcastReceiver()
    }

    fun listenForCode(@NonNull call: MethodCall, @NonNull result: Result) {
        val senderNumber = call.argument<String?>(senderTelephoneNumber)
        // Start listening for SMS User Consent broadcasts from senderPhoneNumber
        // The Task<Void> will be successful if SmsRetriever was able to start
        // SMS User Consent, and will error if there was an error starting.
        if (context != null) {
            val task = SmsRetriever.getClient(context!!).startSmsUserConsent(senderNumber)
        }
    }

    private fun registerToSmsBroadcastReceiver() {
        smsBroadcastReceiver = SmsBroadcastReceiver().also {
            it.smsBroadcastReceiverListener = object : SmsBroadcastReceiver.SmsBroadcastReceiverListener {
                override fun onSuccess(intent: Intent?) {
                    intent?.let { context -> activity.startActivityForResult(context, smsConsentRequest) }
                }

                override fun onFailure() {
                }
            }
        }

        val intentFilter = IntentFilter(SmsRetriever.SMS_RETRIEVED_ACTION)
        activity.registerReceiver(smsBroadcastReceiver, intentFilter)
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}
