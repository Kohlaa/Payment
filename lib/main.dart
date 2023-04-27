import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:payment/my_observer.dart';
import 'package:payment/screens/cash.dart';
import 'package:payment/screens/payment_method.dart';
import 'package:payment/screens/register/register.dart';
import 'package:payment/screens/visa.dart';
import 'package:payment/shared/network/remote/dio_helper.dart';

void main() {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RegisterScreen.routeName,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        PaymentMethod.routeName: (context) => PaymentMethod(),
        CashScreen.routeName: (context) => CashScreen(),
        VisaScreen.routeName: (context) => VisaScreen(),
      },
    );
  }
}
