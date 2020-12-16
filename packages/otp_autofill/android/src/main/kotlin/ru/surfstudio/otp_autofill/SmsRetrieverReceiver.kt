package ru.surfstudio.otp_autofill

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.google.android.gms.auth.api.phone.SmsRetriever
import com.google.android.gms.common.api.CommonStatusCodes
import com.google.android.gms.common.api.Status

class SmsRetrieverReceiver : BroadcastReceiver() {

    lateinit var smsBroadcastReceiverListener: SmsRetrieverBroadcastReceiverListener

    override fun onReceive(context: Context?, intent: Intent?) {

        if (intent?.action == SmsRetriever.SMS_RETRIEVED_ACTION) {

            val extras = intent.extras
            val smsRetrieverStatus = extras?.get(SmsRetriever.EXTRA_STATUS) as Status

            when (smsRetrieverStatus.statusCode) {
                CommonStatusCodes.SUCCESS -> {
                    extras.get(SmsRetriever.EXTRA_SMS_MESSAGE)?.also {
                        smsBroadcastReceiverListener.onSuccess(it as String)
                    }
                }

                CommonStatusCodes.TIMEOUT -> {
                    try {
                        smsBroadcastReceiverListener.onFailure()
                    } catch (e: Exception) {
                        ///DO NOTHING, end listening
                    }
                }
            }
        }
    }

    interface SmsRetrieverBroadcastReceiverListener {
        fun onSuccess(sms: String?)
        fun onFailure()
    }
}