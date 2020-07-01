package ru.surf.surfpay

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import android.view.View
import androidx.annotation.NonNull
import com.google.android.gms.wallet.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.json.JSONObject


const val CHANNEL_NAME = "surfpay"
const val PAY = "pay"
const val PAYMENT_RESPONSE = "payment_response"
const val IS_READY_TO_PAY = "is_ready_to_pay"

/** SurfpayPlugin */
public class SurfpayPlugin() : FlutterPlugin, MethodCallHandler, PluginRegistry.ActivityResultListener, ActivityAware {

    private val LOAD_PAYMENT_DATA_REQUEST_CODE = 8080

    private lateinit var channel: MethodChannel

    private lateinit var googlePaymentsClient: PaymentsClient

    private lateinit var context: Context
    private lateinit var activity: Activity

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), CHANNEL_NAME)
            val surfpayPlugin = SurfpayPlugin()
            channel.setMethodCallHandler(surfpayPlugin)
            registrar.addActivityResultListener(surfpayPlugin);
        }
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity;
        initClient() // работает
        readyToPayRequest() // работает
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == PAY) {
            requestPayment() // проверка
        }
    }

    private fun initClient() {
        val walletOptions =
                Wallet.WalletOptions.Builder()
                        .setEnvironment(WalletConstants.ENVIRONMENT_TEST)
                        .build()

        googlePaymentsClient = Wallet.getPaymentsClient(activity, walletOptions)
    }

    private fun readyToPayRequest() {
        val isReadyToPayRequest = getIsReadyToPayRequest()

        val task = googlePaymentsClient.isReadyToPay(isReadyToPayRequest)
        task.addOnCompleteListener {
            if (it.isComplete) {
                channel.invokeMethod(IS_READY_TO_PAY, true)
            } else {
                channel.invokeMethod(IS_READY_TO_PAY, false)
            }
        }
    }

    private fun requestPayment() {
        val paymentDataRequestJson: JSONObject = getPaymentDataRequest("120.0")!!

        val request = PaymentDataRequest.fromJson(paymentDataRequestJson.toString())

        if (request != null) {
            AutoResolveHelper.resolveTask(
                    googlePaymentsClient.loadPaymentData(request),
                    activity,
                    LOAD_PAYMENT_DATA_REQUEST_CODE)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        Log.d("РЕЗУЛЬТАТ", "Активность сработала")
        when (requestCode) {
            LOAD_PAYMENT_DATA_REQUEST_CODE -> {
                when (resultCode) {
                    Activity.RESULT_OK -> {
                        PaymentData.getFromIntent(data!!)?.let {
                            Log.d("ОПЛАТА", "Оплачено успешно $it")
                            channel!!.invokeMethod(PAYMENT_RESPONSE, "success")
                        }
                    }

                    Activity.RESULT_CANCELED -> {
                        // The user cancelled without selecting a payment method.
                        Log.d("ОТМЕНА", "Оплата отменена")
                    }

                    AutoResolveHelper.RESULT_ERROR -> {
                        AutoResolveHelper.getStatusFromIntent(data)?.let {
                            Log.d("ОШИБКА", "Ошибка оплаты $it")
                        }
                    }
                }
            }
        }
        return true
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}
