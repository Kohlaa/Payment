import 'package:flutter/material.dart';
import 'package:payment/screens/cash.dart';
import 'package:payment/screens/visa.dart';

class PaymentMethod extends StatelessWidget {
  static const String routeName = "pay";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, VisaScreen.routeName);
              },
              child: Text("Visa")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, CashScreen.routeName);
              },
              child: Text("Kiosk")),
        ],
      ),
    );
  }
}
