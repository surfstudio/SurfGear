package ru.surf.surfpay

class GoogleData(
        val allowedAuthMethods: ArrayList<String>,
        val allowedCardNetworks: ArrayList<String>,
        val billingAddressRequired: Boolean,
        val billingAddressParameters: HashMap<String, String>,
        val type: String)