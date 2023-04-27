import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/screens/register/cubit/states.dart';
import 'package:payment/shared/components/constants.dart';
import 'package:payment/shared/network/remote/dio_helper.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(InitPaymentState());

  static PaymentCubit get(context) => BlocProvider.of(context);

  void getAuthToken(
      String email, String phone, String fName, String lName, String amount) {
    emit(LoadingAuthTokenPaymentState());
    DioHelper.postData(endPoint: "auth/tokens", data: {"api_key": API_KEY})
        .then((value) {
      AUTH_TOKEN = value.data["token"];
      print("Kohla's Token >>>>>> $AUTH_TOKEN");
      getOrderID(email, phone, fName, lName, amount);
      emit(SuccessAuthTokenPaymentState());
    }).catchError((error) {
      emit(ErrorAuthTokenPaymentState());
    });
  }

  void getOrderID(
      String email, String phone, String fName, String lName, String amount) {
    emit(LoadingOrderIdPaymentState());
    DioHelper.postData(endPoint: "ecommerce/orders", data: {
      "auth_token": AUTH_TOKEN,
      "delivery_needed": "false",
      "amount_cents": amount,
      "currency": "EGP",
      // "merchant_order_id": ,
      "items": []
    }).then((value) {
      ORDER_ID = value.data["id"].toString();
      getRequestTokenCard(email, phone, fName, lName, amount);
      getRequestTokenKiosk(email, phone, fName, lName, amount);
      emit(SuccessOrderIdPaymentState());
    }).catchError((error) {
      print("$error");
      emit(ErrorOrderIdPaymentState());
    });
  }

  void getRequestTokenCard(
      String email, String phone, String fName, String lName, String amount) {
    emit(LoadingRequestTokenCardPaymentState());
    DioHelper.postData(endPoint: "acceptance/payment_keys", data: {
      "auth_token": AUTH_TOKEN,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": ORDER_ID,
      "billing_data": {
        "apartment": "803",
        "email": email,
        "floor": "42",
        "first_name": fName,
        "street": "Ethan Land",
        "building": "8028",
        "phone_number": phone,
        "shipping_method": "PKG",
        "postal_code": "01898",
        "city": "Jaskolskiburgh",
        "country": "CR",
        "last_name": lName,
        "state": "Utah"
      },
      "currency": "EGP",
      "integration_id": INTEGRATIONCARDID,
    }).then((value) {
      REQUEST_TOKEN_CARD = value.data["token"];
      emit(SuccessRequestTokenCardPaymentState());
    }).catchError((error) {
      emit(ErrorRequestTokenCardPaymentState());
    });
  }

  void getRequestTokenKiosk(
      String email, String phone, String fName, String lName, String amount) {
    emit(LoadingRequestTokenKioskPaymentState());
    DioHelper.postData(endPoint: "acceptance/payment_keys", data: {
      "auth_token": AUTH_TOKEN,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": ORDER_ID,
      "billing_data": {
        "apartment": "803",
        "email": email,
        "floor": "42",
        "first_name": fName,
        "street": "Ethan Land",
        "building": "8028",
        "phone_number": phone,
        "shipping_method": "PKG",
        "postal_code": "01898",
        "city": "Jaskolskiburgh",
        "country": "CR",
        "last_name": lName,
        "state": "Utah"
      },
      "currency": "EGP",
      "integration_id": INTEGRATIONKIOSKID,
    }).then((value) {
      REQUEST_TOKEN_KIOSK = value.data["token"];
      getRefCode();
      emit(SuccessRequestTokenKioskPaymentState());
    }).catchError((error) {
      emit(ErrorRequestTokenKioskPaymentState());
    });
  }

  void getRefCode() {
    emit(LoadingReferenceCodePaymentState());
    DioHelper.postData(endPoint: "acceptance/payments/pay", data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": REQUEST_TOKEN_KIOSK
    }).then((value) {
      REF_CODE = value.data["id"].toString();

      emit(SuccessReferenceCodePaymentState());
    }).catchError((error) {
      emit(ErrorReferenceCodePaymentState());
    });
  }
}
