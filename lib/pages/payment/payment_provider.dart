import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  bool cashOnDSelivery = false;
  bool payment = false;

  chash() {
    cashOnDSelivery = true;
    payment = false;
    notifyListeners();
  }

  paymentui() {
    cashOnDSelivery = false;
    payment = true;
    notifyListeners();
  }
}
