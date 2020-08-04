package ru.surfstudio.otp_user_consent_api

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.google.android.gms.auth.api.phone.SmsRetriever
import com.google.android.gms.common.api.CommonStatusCodes
import com.google.android.gms.common.api.Status

class SmsBroadcastReceiver : BroadcastReceiver() {

    lateinit var smsBroadcastReceiverListener: SmsBroadcastReceiverListener

    override fun onReceive(context: Context?, intent: Intent?) {

        if (intent?.action == SmsRetriever.SMS_RETRIEVED_ACTION) {

            val extras = intent.extras
            val smsRetrieverStatus = extras?.get(SmsRetriever.EXTRA_STATUS) as Status

            when (smsRetrieverStatus.statusCode) {
                CommonStatusCodes.SUCCESS -> {
//                    extras.getParcelable<Intent>(SmsRetriever.EXTRA_CONSENT_INTENT)?.also {
//                        smsBroadcastReceiverListener.onSuccess(it)
//                    }
                    extras.get(SmsRetriever.EXTRA_SMS_MESSAGE)?.also {
                        smsBroadcastReceiverListener.onSuccess(it as String)
                    }
                }

                CommonStatusCodes.TIMEOUT -> {
                    smsBroadcastReceiverListener.onFailure()
                }
            }
        }
    }

    interface SmsBroadcastReceiverListener {
        fun onSuccess(intent: String?)
        fun onFailure()
    }
}