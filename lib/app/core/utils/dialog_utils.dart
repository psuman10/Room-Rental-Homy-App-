import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homy_app/app/core/values/colors.dart';
import 'package:homy_app/app/data/database/homy_database.dart';
import 'package:homy_app/app/data/models/property.dart';

class DialogUtils {
  DialogUtils._();
  static void showAdvancePaymentDialog(
    BuildContext context,
    PropertyModel property,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            "Booking",
            style: Theme.of(context).textTheme.headline5,
          ),
          content: Text(
            "You have to pay Rs. 1000/- to book this property",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.bodyText1,
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _payWithEsewa(property);
                },
                child: Text(
                  "Proceed",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: primaryBlue),
                )),
          ],
        );
      },
    );
  }

  static void _payWithEsewa(PropertyModel property) {
    final esewaConfig = EsewaConfig(
      clientId: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
      secretId: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
      environment: Environment.test,
    );
    final esewaPayment = EsewaPayment(
      productId: "productId",
      productName: "Event1 Registration",
      productPrice: '1000',
      callbackUrl: "",
    );

    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: esewaConfig,
        esewaPayment: esewaPayment,
        onPaymentSuccess: (success) async {
          final isSaved = await HomyDatabase.savePayments(property: property);
          if (isSaved) {
            EasyLoading.showSuccess("Your booking is success");
          } else {
            EasyLoading.showError(
                "Something went wrong while booking, try again");
          }
        },
        onPaymentFailure: (failure) {
          EasyLoading.showError("Payment is failed, Try again later");
        },
        onPaymentCancellation: () {},
      );
    } catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }
}
