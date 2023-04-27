import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/screens/payment_method.dart';
import 'package:payment/screens/register/cubit/cuit.dart';
import 'package:payment/screens/register/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "Register";

  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //PaymentCubit.get(context).getAuthToken();
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child:
          BlocConsumer<PaymentCubit, PaymentStates>(listener: (context, state) {
        if (state is LoadingAuthTokenPaymentState) {
          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     content: CircularProgressIndicator(),
          //   ),
          // );
          print("hiiiii");
        }
        if (state is SuccessAuthTokenPaymentState) {
          print("Hi Kohla");
        }
        if(state is SuccessReferenceCodePaymentState){
          Navigator.pushNamed(context, PaymentMethod.routeName);
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Payment"),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: fNameController,
                      decoration: InputDecoration(
                          hintText: "First Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: lNameController,
                      decoration: InputDecoration(
                          hintText: "Last Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          hintText: "Phone",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: amountController,
                      decoration: InputDecoration(
                          hintText: "Amount",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          PaymentCubit.get(context).getAuthToken(
                              emailController.text,
                              phoneController.text,
                              fNameController.text,
                              lNameController.text,
                              amountController.text);
                        },
                        child: Text("Let's go"))
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
