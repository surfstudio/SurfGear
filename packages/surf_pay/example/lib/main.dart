import 'package:flutter/material.dart';
import 'package:surfpay/data/apple_pay_data.dart';
import 'package:surfpay/data/google_pay_data.dart';
import 'package:surfpay/surfpay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Surfpay(

            applePayData: ApplePayData(
              MerchantCapabilities.capability3DS,
              'merchant.example.surfpay',
              [
                PaymentNetwork.visa,
                PaymentNetwork.masterCard,
              ],
            ),
            googlePayData: GooglePayData(
              [
                'PAN_ONLY',
                'CRYPTOGRAM_3DS',
              ],
              [
                'MASTERCARD',
                'VISA',
              ],
              true,
              {
                'format': 'FULL',
              },
              'CARD',
              'example',
              'exampleGatewayMerchantId',
              'PAYMENT_GATEWAY',
            ),
            onSuccess: (status) {
              print('End with status - $status');
            },
            onCancel: () => print('Canceled'),
            onError: (_) => print('Error'),
          ),
        ),
      ),
    );
  }
}
