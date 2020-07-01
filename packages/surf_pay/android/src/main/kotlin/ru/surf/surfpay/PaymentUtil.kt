package ru.surf.surfpay

import com.google.android.gms.wallet.IsReadyToPayRequest
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

fun getIsReadyToPayRequest(): IsReadyToPayRequest {
    val isReadyToPayRequest = getBaseRequest()
    isReadyToPayRequest.put(
            "allowedPaymentMethods", JSONArray().put(baseCardPaymentMethod()))

    return IsReadyToPayRequest.fromJson(isReadyToPayRequest.toString())
}

fun getPaymentDataRequest(price: String,
                          allowedAuthMethods: Array<String>,
                          allowedCardNetworks: Array<String>,
                          billingAddressRequired: Boolean,
                          billingAddressParameters: HashMap<String, String>,
                          type: String,
                          merchantInfo: HashMap<String, String>,
                          phoneNumberRequired: Boolean,
                          allowedCountryCodes: List<String>,
                          shippingAddressRequired: Boolean
): JSONObject? {
    try {
        return JSONObject(getBaseRequest().toString()).apply {
            put("allowedPaymentMethods",
                    JSONArray().put(getCardPaymentMethod(allowedAuthMethods,
                            allowedCardNetworks,
                            billingAddressRequired,
                            billingAddressParameters,
                            type)))
            put("transactionInfo", getTransactionInfo(price))
            put("merchantInfo", getMerchantInfo(merchantInfo))

            // An optional shipping address requirement is a top-level property of the
            // PaymentDataRequest JSON object.
            val shippingAddressParameters = JSONObject().apply {
                //todo replace up
                put("phoneNumberRequired", false)
                put("phoneNumberRequired", phoneNumberRequired)
                //todo replace up
                put("allowedCountryCodes", JSONArray(listOf("US", "GB")))
                put("allowedCountryCodes", JSONArray(allowedCountryCodes))
            }
            //todo replace up
            put("shippingAddressRequired", true)
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
    //todo replace up
    return JSONObject().put("merchantName", "Example Merchant")
}

private fun baseCardPaymentMethod(
        allowedAuthMethods: Array<String>,
        allowedCardNetworks: Array<String>,
        billingAddressRequired: Boolean,
        //todo сделать парсинг
        billingAddressParameters: HashMap<String, String>,
        type: String
): JSONObject {
    return JSONObject().apply {

        val parameters = JSONObject().apply {
            put("allowedAuthMethods", getAllowedCardAuthMethods(allowedAuthMethods))
            put("allowedCardNetworks", getAllowedCardNetworks(allowedCardNetworks))
            put("billingAddressRequired", billingAddressRequired)
            put("billingAddressParameters", JSONObject().apply {
                //todo replace up
                put("format", "FULL")
            })
        }

        put("type", type)
        //todo replace up
        put("type", "CARD")

        put("parameters", parameters)
    }
}

private fun getCardPaymentMethod(allowedAuthMethods: Array<String>,
                                 allowedCardNetworks: Array<String>,
                                 billingAddressRequired: Boolean,
                                 billingAddressParameters: HashMap<String, String>,
                                 type: String): JSONObject? {
    val cardPaymentMethod = baseCardPaymentMethod(allowedAuthMethods,
            allowedCardNetworks,
            billingAddressRequired,
            billingAddressParameters,
            type)
    cardPaymentMethod.put("tokenizationSpecification", getGatewayTokenizationSpecification())
    return cardPaymentMethod
}

private fun getBaseRequest(apiVersion: Int, apiVersionMinor: Int): JSONObject {
    return JSONObject()
            //todo replace up
            .put("apiVersion", 2)
            .put("apiVersion", apiVersion)
            //todo replace up
            .put("apiVersionMinor", 0)
            .put("apiVersionMinor", apiVersionMinor)
}

private fun getGatewayTokenizationSpecification(): JSONObject? {
    return object : JSONObject() {
        init {
            put("type", "PAYMENT_GATEWAY")
            put("parameters", object : JSONObject() {
                init {
                    put("gateway", "example")
                    put("gatewayMerchantId", "exampleGatewayMerchantId")
                }
            })
        }
    }
}

private fun getAllowedCardNetworks(cardNetworks: Array<String>): JSONArray {
    return object : JSONArray() {
        init {
            put(cardNetworks)
            //todo replace up
            put("AMEX")
            put("DISCOVER")
            put("INTERAC")
            put("JCB")
            put("MASTERCARD")
            put("VISA")
        }
    }
}

private fun getAllowedCardAuthMethods(authMethods: Array<String>): JSONArray? {
    return object : JSONArray() {
        init {
            put(authMethods)
            //todo replace up
            put("PAN_ONLY")
            put("CRYPTOGRAM_3DS")
        }
    }
}