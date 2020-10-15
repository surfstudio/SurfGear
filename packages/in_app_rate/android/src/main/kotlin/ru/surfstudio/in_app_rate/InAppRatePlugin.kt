package ru.surfstudio.in_app_rate

import android.app.Activity
import androidx.annotation.NonNull;
import com.google.android.play.core.review.ReviewManager
import com.google.android.play.core.review.ReviewManagerFactory
import com.google.android.play.core.review.testing.FakeReviewManager

import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/// Channel
const val channelName = "in_app_rate"

/// Methods
const val openRatingDialog = "openRatingDialog"

/// Arguments
const val isTestEnvironment = "isTestEnvironment"

/** InAppRatePlugin */
public class InAppRatePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), channelName)
        channel.setMethodCallHandler(this);
    }

    companion object {
        private var activity: Activity? = null

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), channelName)
            InAppRatePlugin.activity = registrar.activity()
            channel.setMethodCallHandler(InAppRatePlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            openRatingDialog -> {
                openDialog(call, result)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /// ActivityAware
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.getActivity()
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.getActivity()
    }

    /// Methods
    private fun openDialog(call: MethodCall, flutterResult: Result) {
        if (activity != null) {
            val params = call.arguments as Map<String, Any>
            val isTest = params[isTestEnvironment] as Boolean?

            var manager = if (isTest == true) FakeReviewManager(activity!!.applicationContext) else ReviewManagerFactory.create(activity!!.applicationContext)
            val request = manager.requestReviewFlow()
            request.addOnCompleteListener { request ->
                if (request.isSuccessful) {
                    val flow = manager.launchReviewFlow(activity!!, request.result)
                    flow.addOnCompleteListener { _ ->
                        // The flow has finished. The API does not indicate whether the user
                        // reviewed or not, or even whether the review dialog was shown. Thus, no
                        // matter the result, we continue our app flow.

                        flutterResult.success(flow.isSuccessful)
                    }
                } else {
                    if (request.exception != null) {
                        flutterResult.error(request.exception.hashCode().toString(), request.exception?.message, null)
                    } else {
                        flutterResult.error("404", "Undefined", null)
                    }

                }
            }
        }
    }
}
