package ru.surf.surfpay

import com.google.android.gms.wallet.IsReadyToPayRequest
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

const val defaultApiVersion = 2
const val defaultApiVersionMinor = 0

fun getIsReadyToPayRequest(googleData: GoogleData): IsReadyToPayRequest {
    val isReadyToPayRequest = getBaseRequest()
    isReadyToPayRequest.put(
            "allowedPaymentMethods", JSONArray()
            .put(baseCardPaymentMethod(
                    googleData.allowedAuthMethods,
                    googleData.allowedCardNetworks,
                    googleData.billingAddressRequired,
                    googleData.billingAddressParameters,
                    googleData.type))
    )

    return IsReadyToPayRequest.fromJson(isReadyToPayRequest.toString())
}


fun getPaymentDataRequest(price: String,
                          googleData: GoogleData,
                          gatewayInfo: GatewayInfo,
                          merchantInfo: HashMap<String, String>,
                          phoneNumberRequired: Boolean,
                          allowedCountryCodes: List<String>,
                          shippingAddressRequired: Boolean
): JSONObject? {
    try {
        return JSONObject(getBaseRequest().toString()).apply {
            put("allowedPaymentMethods",
                    JSONArray().put(getCardPaymentMethod(
                            googleData.allowedAuthMethods,
                            googleData.allowedCardNetworks,
                            googleData.billingAddressRequired,
                            googleData.billingAddressParameters,
                            googleData.type,
                            gatewayInfo)))
            put("transactionInfo", getTransactionInfo(price))
            put("merchantInfo", getMerchantInfo(merchantInfo))

            // An optional shipping address requirement is a top-level property of the
            // PaymentDataRequest JSON object.
            val shippingAddressParameters = JSONObject().apply {
                put("phoneNumberRequired", phoneNumberRequired)
                put("allowedCountryCodes", JSONArray(allowedCountryCodes))
            }
            put("shippingAddressRequired", shippingAddressRequired)
            put("shippingAddressParameters", shippingAddressParameters)
        }
    } catch (e: JSONException) {
        return null
    }
}

private fun getTransactionInfo(price: String): JSONObject? {
    val transactionInfo = JSONObject()
    transactionInfo.put("totalPrice", price)
    transactionInfo.put("totalPriceStatus", "FINAL")
    transactionInfo.put("countryCode", "US")
    transactionInfo.put("currencyCode", "USD")
    return transactionInfo
}

private fun getMerchantInfo(merchantInfo: HashMap<String, String>): JSONObject? {
    return JSONObject().apply {
        if (merchantInfo["merchantId"] != null) put("merchantId", merchantInfo["merchantId"])
        if (merchantInfo["merchantName"] != null) put("merchantName", merchantInfo["merchantName"])
        if (merchantInfo["merchantOrigin"] != null) put("merchantOrigin", merchantInfo["merchantOrigin"])
    }
}

private fun baseCardPaymentMethod(
        allowedAuthMethods: ArrayList<String>,
        allowedCardNetworks: ArrayList<String>,
        billingAddressRequired: Boolean,
        billingAddressParameters: HashMap<String, String>,
        type: String
): JSONObject {
    return JSONObject().apply {

        val parameters = JSONObject().apply {
            put("allowedAuthMethods", getAllowedCardAuthMethods(allowedAuthMethods))
            put("allowedCardNetworks", getAllowedCardNetworks(allowedCardNetworks))
            put("billingAddressRequired", billingAddressRequired)
            put("billingAddressParameters", JSONObject().apply {
                put("format", billingAddressParameters["format"])
                if (billingAddressParameters["phoneNumberRequired"] != null) {
                    put("phoneNumberRequired", billingAddressParameters["phoneNumberRequired"])
                }
            })
        }
        put("type", type)
        put("parameters", parameters)
    }
}

private fun getCardPaymentMethod(allowedAuthMethods: ArrayList<String>,
                                 allowedCardNetworks: ArrayList<String>,
                                 billingAddressRequired: Boolean,
                                 billingAddressParameters: HashMap<String, String>,
                                 type: String,
                                 gatewayInfo: GatewayInfo): JSONObject? {
    val cardPaymentMethod = baseCardPaymentMethod(allowedAuthMethods,
            allowedCardNetworks,
            billingAddressRequired,
            billingAddressParameters,
            type)
    cardPaymentMethod.put("tokenizationSpecification", gatewayInfo.getGatewayTokenizationSpecification())
    return cardPaymentMethod
}

private fun getBaseRequest(apiVersion: Int = defaultApiVersion, apiVersionMinor: Int = defaultApiVersionMinor): JSONObject {
    return JSONObject()
            .put("apiVersion", apiVersion)
            .put("apiVersionMinor", apiVersionMinor)
}

private fun getAllowedCardNetworks(cardNetworks: ArrayList<String>): JSONArray {
    return object : JSONArray() {
        init {
            cardNetworks.forEach {put(it)}
        }
    }
}

private fun getAllowedCardAuthMethods(authMethods: ArrayList<String>): JSONArray? {
    return object : JSONArray() {
        init {
            authMethods.forEach {put(it)}
        }
    }
}