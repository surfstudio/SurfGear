package ru.surf.surfpay

import org.json.JSONObject

/// https://developers.google.com/pay/api/android/reference/object#PaymentMethodTokenizationSpecification
class GatewayInfo(
        val gateway: String,
        val gatewayType: String,
        val gatewayMerchantId: String
) {
    fun getGatewayTokenizationSpecification(): JSONObject? {
        return object : JSONObject() {
            init {
                put("type", gatewayType)
                put("parameters", object : JSONObject() {
                    init {
                        put("gateway", gateway)
                        put("gatewayMerchantId", gatewayMerchantId)
                    }
                })
            }
        }
    }
}