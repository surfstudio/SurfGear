package ru.surfstudio.otp_autofill

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

/// Channel
const val channelName: String = "otp_surfstudio"

/// Requests
const val credentialPickerRequest = 1
const val smsConsentRequest = 2

/// Methods
const val getTelephoneHint: String = "getTelephoneHint"
const val startListenUserConsent: String = "startListenUserConsent"
const val startListenRetriever: String = "startListenRetriever"
const val stopListenForCode: String = "stopListenForCode"
const val getAppSignatureMethod: String = "getAppSignature"

/// Arguments
const val senderTelephoneNumber: String = "senderTelephoneNumber"

/** OtpTextEditControllerPlugin */
public class OTPPlugin : FlutterPlugin, MethodCallHandler, PluginRegistry.ActivityResultListener, ActivityAware {

    private lateinit var channel: MethodChannel

    private var smsUserConsentBroadcastReceiver: SmsUserConsentReceiver? = null
    private var smsRetrieverBroadcastReceiver: SmsRetrieverReceiver? = null
    private var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, channelName)
        channel.setMethodCallHandler(this);
    }

    companion object {
        private var context: Context? = null
        private var lastResult: Result? = null

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            context = registrar.context()
            val channel = MethodChannel(registrar.messenger(), channelName)
            val plugin = OTPPlugin()
            channel.setMethodCallHandler(plugin)
            registrar.addActivityResultListener(plugin)
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            startListenRetriever -> {
                listenRetriever(result)
            }
            startListenUserConsent -> {
                listenUserConsent(call, result)
            }
            getTelephoneHint -> {
                showNumberHint(result)
            }
            stopListenForCode -> {
                unRegisterBroadcastReceivers()
                result.success(true)
            }
            getAppSignatureMethod -> {
                if (activity != null) {
                    val signature = AppSignatureHelper(this.activity!!).getAppSignatures()[0]
                    result.success(signature)
                } else result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun showNumberHint(result: Result) {
        lastResult = result
        if (activity != null) {
            val hintRequest = HintRequest.Builder()
                    .setPhoneNumberIdentifierSupported(true)
                    .build()
            val credentialsClient = Credentials.getClient(activity!!)
            val intent = credentialsClient.getHintPickerIntent(hintRequest)
            activity!!.startIntentSenderForResult(
                    intent.intentSender,
                    credentialPickerRequest,
                    null, 0, 0, 0
            )
        }

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
                    lastResult?.success(message)
                } else {
                    // Consent denied. User can type OTC manually.
                }
            credentialPickerRequest -> if (resultCode == Activity.RESULT_OK && data != null) {
                val credential = data.getParcelableExtra<Credential>(Credential.EXTRA_KEY)
                lastResult?.success(credential?.id)
            }
        }
        return true
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity
        binding.addActivityResultListener(this)
    }

    private fun listenUserConsent(@NonNull call: MethodCall, @NonNull result: Result) {
        val senderNumber = call.argument<String?>(senderTelephoneNumber)
        // Start listening for SMS User Consent broadcasts from senderPhoneNumber
        // The Task<Void> will be successful if SmsRetriever was able to start
        // SMS User Consent, and will error if there was an error starting.
        if (context != null) {
            lastResult = result
            val task = SmsRetriever.getClient(context!!).startSmsUserConsent(senderNumber)
            task.addOnSuccessListener { registerSmsUserConsentBroadcastReceiver() }
        }
    }

    private fun listenRetriever(@NonNull result: Result) {
        if (activity != null) {
            lastResult = result
            val client = SmsRetriever.getClient(activity!!)
            val task = client.startSmsRetriever()
            task.addOnSuccessListener { registerSmsRetrieverBroadcastReceiver() }
        }
    }

    private fun registerSmsUserConsentBroadcastReceiver() {
        smsUserConsentBroadcastReceiver = SmsUserConsentReceiver().also {
            it.smsBroadcastReceiverListener = object : SmsUserConsentReceiver.SmsUserConsentBroadcastReceiverListener {
                override fun onSuccess(intent: Intent?) {
                    intent?.let { context -> activity?.startActivityForResult(context, smsConsentRequest) }
                }

                override fun onFailure() {
                    lastResult?.error("408", "Timeout exception", null)
                }
            }
        }

        val intentFilter = IntentFilter(SmsRetriever.SMS_RETRIEVED_ACTION)
        this.activity?.registerReceiver(smsUserConsentBroadcastReceiver, intentFilter, SmsRetriever.SEND_PERMISSION, null)
    }

    private fun registerSmsRetrieverBroadcastReceiver() {
        smsRetrieverBroadcastReceiver = SmsRetrieverReceiver().also {
            it.smsBroadcastReceiverListener = object : SmsRetrieverReceiver.SmsRetrieverBroadcastReceiverListener {
                override fun onSuccess(sms: String?) {
                    sms?.let { it -> lastResult?.success(it) }
                }

                override fun onFailure() {
                    lastResult?.error("408", "Timeout exception", null)
                }
            }
        }

        val intentFilter = IntentFilter(SmsRetriever.SMS_RETRIEVED_ACTION)
        this.activity?.registerReceiver(smsRetrieverBroadcastReceiver, intentFilter)
    }

    private fun unRegisterBroadcastReceivers() {
        if (smsUserConsentBroadcastReceiver != null) {
            activity?.unregisterReceiver(smsUserConsentBroadcastReceiver)
            smsUserConsentBroadcastReceiver = null
        }
        if (smsRetrieverBroadcastReceiver != null) {
            activity?.unregisterReceiver(smsRetrieverBroadcastReceiver)
            smsRetrieverBroadcastReceiver = null
        }
    }

    override fun onDetachedFromActivity() {
        unRegisterBroadcastReceivers()
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}
