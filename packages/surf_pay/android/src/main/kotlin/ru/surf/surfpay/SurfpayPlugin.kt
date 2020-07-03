package ru.surf.surfpay

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
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

/// Methods
const val IS_READY_TO_PAY = "is_ready_to_pay"
const val PAY = "pay"
const val IS_READY_CALLBACK = "is_ready_to_pay"

const val ON_SUCCESS = "payment_success"
const val ON_CANCEL = "payment_cancel"
const val ON_ERROR = "payment_error"

/// Arguments
const val PAYMENT_STATUS = "status"

const val ALLOWED_AUTH_METHODS = "allowedAuthMethods"
const val ALLOWED_CARD_NETWORKS = "allowedCardNetworks"
const val BILLING_ADDRESS_REQUIRED = "billingAddressRequired"
const val BILLING_ADDRESS_PARAMETERS = "billingAddressParameters"
const val TYPE = "type"

const val PRICE = "price"
const val MERCHANT_INFO = "merchantInfo"
const val PHONE_NUMBER_REQUIRED = "phoneNumberRequired"
const val ALLOWED_COUNTRY_CODES = "allowedCountryCodes"
const val SHIPPING_ADDRESS_REQUIRED = "shippingAddressRequired"

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
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            PAY -> {
                requestPayment(call)
                result.success(null)
            }
            IS_READY_TO_PAY -> {
                isReadyToPayRequest(call, result)
            }
        }
    }

    private fun initClient() {
        val walletOptions =
                Wallet.WalletOptions.Builder()
                        .setEnvironment(WalletConstants.ENVIRONMENT_TEST)
                        .build()

        googlePaymentsClient = Wallet.getPaymentsClient(activity, walletOptions)
    }

    private fun isReadyToPayRequest(call: MethodCall, result: Result) {
        val params = call.arguments as Map<String, Any>

        val allowedAuthMethods = params[ALLOWED_AUTH_METHODS] as ArrayList<String>
        val allowedCardNetworks = params[ALLOWED_CARD_NETWORKS] as ArrayList<String>
        val billingAddressRequired = params[BILLING_ADDRESS_REQUIRED] as Boolean
        val billingAddressParameters = params[BILLING_ADDRESS_PARAMETERS] as HashMap<String, String>
        val type = params[TYPE] as String

        val isReadyToPayRequest = getIsReadyToPayRequest(
                allowedAuthMethods,
                allowedCardNetworks,
                billingAddressRequired,
                billingAddressParameters,
                type)

        val task = googlePaymentsClient.isReadyToPay(isReadyToPayRequest)
        task.addOnCompleteListener {
            result.success(it.isSuccessful)
        }
    }

    private fun requestPayment(call: MethodCall) {
        val params = call.arguments as Map<String, Any>

        val price = params[PRICE] as String
        val allowedAuthMethods = params[ALLOWED_AUTH_METHODS] as ArrayList<String>
        val allowedCardNetworks = params[ALLOWED_CARD_NETWORKS] as ArrayList<String>
        val billingAddressRequired = params[BILLING_ADDRESS_REQUIRED] as Boolean
        val billingAddressParameters = params[BILLING_ADDRESS_PARAMETERS] as HashMap<String, String>
        val type = params[TYPE] as String
        val merchantInfo = params[MERCHANT_INFO] as HashMap<String, String>
        val phoneNumberRequired = params[PHONE_NUMBER_REQUIRED] as Boolean
        val allowedCountryCodes = params[ALLOWED_COUNTRY_CODES] as List<String>
        val shippingAddressRequired = params[SHIPPING_ADDRESS_REQUIRED] as Boolean

        val paymentDataRequestJson = getPaymentDataRequest(
                price,
                allowedAuthMethods,
                allowedCardNetworks,
                billingAddressRequired,
                billingAddressParameters,
                type,
                merchantInfo,
                phoneNumberRequired,
                allowedCountryCodes,
                shippingAddressRequired)

        if (paymentDataRequestJson != null) {
            val request = PaymentDataRequest.fromJson(paymentDataRequestJson.toString())

            if (request != null) {
                AutoResolveHelper.resolveTask(
                        googlePaymentsClient.loadPaymentData(request),
                        activity,
                        LOAD_PAYMENT_DATA_REQUEST_CODE)
            }
        }
        //todo Throw Exception
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        when (requestCode) {
            LOAD_PAYMENT_DATA_REQUEST_CODE -> {
                when (resultCode) {
                    Activity.RESULT_OK -> {
                        PaymentData.getFromIntent(data!!)?.let {
                            channel!!.invokeMethod(ON_SUCCESS, "success")
                        }
                    }

                    Activity.RESULT_CANCELED -> {
                        channel!!.invokeMethod(ON_CANCEL, "cancel")
                    }

                    AutoResolveHelper.RESULT_ERROR -> {
                        AutoResolveHelper.getStatusFromIntent(data)?.let {
                            channel!!.invokeMethod(ON_ERROR, mapOf(PAYMENT_STATUS to it.statusCode))
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
