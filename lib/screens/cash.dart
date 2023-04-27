import 'package:flutter/material.dart';
import 'package:payment/shared/components/constants.dart';

class CashScreen extends StatelessWidget {
static const String routeName ="cash";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Pay with that reference code $REF_CODE")),
    );
  }
}
